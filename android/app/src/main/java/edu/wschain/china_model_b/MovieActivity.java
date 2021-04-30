package edu.wschain.china_model_b;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.VideoView;

import androidx.appcompat.app.AppCompatActivity;

import java.net.URI;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.view.FlutterView;

public class MovieActivity extends FlutterActivity {

    private VideoView videoView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        this.requestWindowFeature(Window.FEATURE_NO_TITLE);
        super.onCreate(savedInstanceState);
//        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);



        setContentView(R.layout.movie_layout);
        setNavigation();
        initView();
    }

    private void initView() {
        videoView = (VideoView) findViewById(R.id.videoView);


        String url = getIntent().getStringExtra("URL");
        videoView.setVideoURI(Uri.parse(url));
//        videoView.setVideoURI(Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.banner));
//        videoView.requestFocus();
        videoView.start();
        videoView.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            @Override
            public void onCompletion(MediaPlayer mp) {
                videoView.start();
            }
        });
    }


    /**
     * 设置状态栏和导航栏
     */
    private void setNavigation() {
        //设置不需要顶部的任务栏
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);

        //设置底部的导航栏消失 ----SDK 19 以上
        View decorView = getWindow().getDecorView();
        int view = View.SYSTEM_UI_FLAG_IMMERSIVE | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION;
        decorView.setSystemUiVisibility(view);
    }
}
