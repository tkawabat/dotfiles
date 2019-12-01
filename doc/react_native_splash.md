# React-Nativeでのsplashの設定方法

## iOS
* 以下のファイルを変更
    * ios/APP_NAME/Supporting/launch_background_image.png

## Android
* 以下のファイルにファイルを置く
    * android/app/src/main/res/drawable-/*png
    * app/src/main/res/layout/launch_screen.xml

    ```
    <?xml version="1.0" encoding="utf-8"?>
    <FrameLayout
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        >
        <ImageView
            android:src="@drawable/shell_launch_background_image"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:scaleType="centerCrop"
            >
        </ImageView>
    </FrameLayout>
    ```

* 画像は全部サイズは1440*2560
    * サイズ変えたらタブレットで画質が下がった

## うまくいかなった方法
* react-native-splash-screen
    * https://github.com/crazycodeboy/react-native-splash-screen
    * 設定の仕方に書いてあるようなファイルがなかった
    * iosでヘッダーの読み込みでファイルが見つからなかった
    * androidもiosも使ってみたけど、ダメ！
* assets/splash.png
    * ファイルを変更しても反映されず
    * App.jsonを変更してみてもダメ


