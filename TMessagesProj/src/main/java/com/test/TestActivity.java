package com.test;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;

import org.telegram.messenger.AndroidUtilities;
import org.telegram.messenger.FileLog;
import org.telegram.messenger.MediaController;
import org.telegram.messenger.R;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * Created by Administrator on 2016/10/30.
 */

public class TestActivity extends AppCompatActivity {
    String currentPicturePath;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_test);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        Intent test = new Intent(MediaStore.ACTION_VIDEO_CAPTURE);
//设置视频大小
        test.putExtra(MediaStore.EXTRA_SIZE_LIMIT,
                768000);
        File file = new File(getExternalCacheDir(), "tmp.mp4");
//        File file = new File(Environment.getExternalStorageDirectory(), "tmp.mp4");
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        test.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(file));  // set the image file name
//设置视频时间  毫秒单位
        test.putExtra(
                MediaStore.EXTRA_DURATION_LIMIT, 45000);
        startActivityForResult(test, 2);


//        File file = new File("/storage/emulated/0/_tmp.mp4");
//        if(!file.exists())
//            try {
//                file.createNewFile();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        converVideo("/storage/emulated/0/tmp.mp4",
//                "/storage/emulated/0/_tmp.mp4");
    }

    public void converVideo(final String file, final String cacheFile) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                boolean result = new MediaController().convertVideo(file, -1, -1, cacheFile, 360, 640, 0, 450000);
                FileLog.e("压缩", result ? "视频压缩成功" : "视频压缩失败");
            }
        }).start();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 2) {
            String videoPath = null;
            FileLog.e("tmessages", "pic path " + currentPicturePath);
            if (data != null && currentPicturePath != null) {
                if (new File(currentPicturePath).exists()) {
                    data = null;
                }
            }
            if (data != null) {
                Uri uri = data.getData();
                if (uri != null) {
                    FileLog.e("tmessages", "video record uri " + uri.toString());
                    videoPath = AndroidUtilities.getPath(uri);
                    FileLog.e("tmessages", "resolved path = " + videoPath);
                    if (!(new File(videoPath).exists())) {
                        videoPath = currentPicturePath;
                    }
                } else {
                    videoPath = currentPicturePath;
                }
//                AndroidUtilities.addMediaToGallery(currentPicturePath);
                currentPicturePath = null;
            }
            if (videoPath == null && currentPicturePath != null) {
                File f = new File(currentPicturePath);
                if (f.exists()) {
                    videoPath = currentPicturePath;
                }
                currentPicturePath = null;
            }
            if (Build.VERSION.SDK_INT >= 16) {
                Bundle args = new Bundle();
                args.putString("videoPath", videoPath);
                VideoEditorFragment fragment = new VideoEditorFragment(args);
                fragment.setDelegate(new VideoEditorFragment.VideoEditorActivityDelegate() {
                    @Override
                    public void didFinishEditVideo(String videoPath, long startTime, long endTime, int resultWidth, int resultHeight, int rotationValue, int originalWidth, int originalHeight, int bitrate, long estimatedSize, long estimatedDuration) {
                        File file = new File(Environment.getExternalStorageDirectory(), UUID.randomUUID() + ".mp4");
                        try {
                            file.createNewFile();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        converVideo(videoPath, file.getAbsolutePath());
                    }
                });
                getSupportFragmentManager().beginTransaction().add(R.id.frag_container, fragment, "video").commit();
            }
        }
    }
}
