import UIKit
import Flutter

import UserNotifications
import YandexMobileMetrica
import YandexMobileMetricaPush



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Initializing the AppMetrica SDK.
    let configuration = YMMYandexMetricaConfiguration.init(apiKey: "a9ecc76c-4f5b-4dc5-b289-e23dffbd7414")
    YMMYandexMetrica.activate(with: configuration!)
      
    // Register for push notifications
    if #available(iOS 10.0, *) {
        // iOS 10.0 and above.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
    } else {
        // iOS 8 and iOS 9.
        let settings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()

    if #available(iOS 10.0, *) {
        let delegate = YMPYandexMetricaPush.userNotificationCenterDelegate()
        UNUserNotificationCenter.current().delegate = delegate
    }


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        // If the AppMetrica SDK library was not initialized before this step,
        // calling the method causes the app to crash.
        #if DEBUG
            let pushEnvironment = YMPYandexMetricaPushEnvironment.development
        #else
            let pushEnvironment = YMPYandexMetricaPushEnvironment.production
        #endif
        YMPYandexMetricaPush.setDeviceTokenFrom(deviceToken, pushEnvironment: pushEnvironment)
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any])
    {
        self.handlePushNotification(userInfo)
    }

    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        self.handlePushNotification(userInfo)
        completionHandler(.newData)
    }

    func handlePushNotification(_ userInfo: [AnyHashable : Any])
    {
        // Track received remote notification.
        // Method [YMMYandexMetrica activateWithApiKey:] should be called before using this method.
        YMPYandexMetricaPush.handleRemoteNotification(userInfo)
    }
    
    
}
