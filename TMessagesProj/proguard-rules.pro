#指定代码的压缩级别
    -optimizationpasses 5

    #包明不混合大小写
    -dontusemixedcaseclassnames

    #不去忽略非公共的库类
    -dontskipnonpubliclibraryclasses

     #优化  不优化输入的类文件
    -dontoptimize

     #预校验
    -dontpreverify

     #混淆时是否记录日志
    -verbose

     # 混淆时所采用的算法
    -optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

    #保护注解
    -keepattributes *Annotation*

    # 保持哪些类不被混淆
    -keep public class * extends android.app.Fragment
    -keep public class * extends android.app.Activity
    -keep public class * extends android.app.Application
    -keep public class * extends android.app.Service
    -keep public class * extends android.content.BroadcastReceiver
    -keep public class * extends android.content.ContentProvider
    -keep public class * extends android.app.backup.BackupAgentHelper
    -keep public class * extends android.preference.Preference
    -keep public class com.android.vending.licensing.ILicensingService
    #如果有引用v4包可以添加下面这行
    -keep public class * extends android.support.v4.app.Fragment



    #忽略警告
    -ignorewarning

    ##记录生成的日志数据,gradle build时在本项目根目录输出##

    #apk 包内所有 class 的内部结构
    -dump class_files.txt
    #未混淆的类和成员
    -printseeds seeds.txt
    #列出从 apk 中删除的代码
    -printusage unused.txt
    #混淆前后的映射
    -printmapping mapping.txt

    ########记录生成的日志数据，gradle build时 在本项目根目录输出-end######


    #####混淆保护自己项目的部分代码以及引用的第三方jar包library#######




        #如果引用了v4或者v7包
        -dontwarn android.support.**

        ####混淆保护自己项目的部分代码以及引用的第三方jar包library-end####

        -keep public class * extends android.view.View {
            public <init>(android.content.Context);
            public <init>(android.content.Context, android.util.AttributeSet);
            public <init>(android.content.Context, android.util.AttributeSet, int);
            public void set*(...);
        }


        #保持 native 方法不被混淆
            -keepclasseswithmembernames class * {
                native <methods>;
            }

            #保持自定义控件类不被混淆
            -keepclasseswithmembers class * {
                public <init>(android.content.Context, android.util.AttributeSet);
            }

            #保持自定义控件类不被混淆
            -keepclassmembers class * extends android.app.Activity {
               public void *(android.view.View);
            }

            #保持 Parcelable 不被混淆
            -keep class * implements android.os.Parcelable {
              public static final android.os.Parcelable$Creator *;
            }

            #保持 Serializable 不被混淆
            -keepnames class * implements java.io.Serializable

            #保持 Serializable 不被混淆并且enum 类也不被混淆
            -keepclassmembers class * implements java.io.Serializable {
                static final long serialVersionUID;
                private static final java.io.ObjectStreamField[] serialPersistentFields;
                !static !transient <fields>;
                !private <fields>;
                !private <methods>;
                private void writeObject(java.io.ObjectOutputStream);
                private void readObject(java.io.ObjectInputStream);
                java.lang.Object writeReplace();
                java.lang.Object readResolve();
            }

            #保持枚举 enum 类不被混淆 如果混淆报错，建议直接使用上面的 -keepclassmembers class * implements java.io.Serializable即可
            #-keepclassmembers enum * {
            #  public static **[] values();
            #  public static ** valueOf(java.lang.String);
            #}

            #不混淆资源类
                -keepclassmembers class **.R$* {
                    public static <fields>;
                }

                #避免混淆泛型 如果混淆报错建议关掉
                    #–keepattributes Signature

                    -keepattributes Signature
                        # Gson specific classes
                        -keep class sun.misc.Unsafe { *; }
                        # Application classes that will be serialized/deserialized over Gson
                        -keep class com.mxdnp.widget.MessageBody { *; }




#eventbus3
-keepattributes *Annotation*
-keepclassmembers class ** {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode {
      *;
}
# Only required if you use AsyncExecutor
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}


#okhttp3
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
-dontwarn okio.**

#glide
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}

 # universal-image-loader 混淆

-dontwarn com.nostra13.universalimageloader.**
-keep class com.nostra13.universalimageloader.** { *; }


#oss-android-sdk
-keep class com.alibaba.sdk.android.oss.** { *; }
-dontwarn okio.**
-dontwarn org.apache.commons.codec.binary.**


#不混淆jackson
-dontwarn org.codehaus.jackson.**
-keep class org.codehaus.jackson.** {*; }
-keep interface org.codehaus.jackson.** { *; }
-keep public class * extends org.codehaus.jackson.**
-keep public class com.github.fge.jackson.**{*;}
-keep class com.fasterxml.jackson.** { *; }
-dontwarn com.fasterxml.jackson.databind.**

# OkHttp2
-dontwarn com.squareup.okhttp.**
-keep class com.squareup.okhttp.** {*;}
-keep interface com.squareup.okhttp.** {*;}
-dontwarn okio.**

-keepattributes InnerClasses

