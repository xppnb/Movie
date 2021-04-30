package edu.wschain.china_model_b;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import edu.wschain.china_model_b.Utils.Constant;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        new MethodChannel(getFlutterView(),"android").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                switch (call.method){
                    case "movieTest":
                        Toast.makeText(MainActivity.this, "长按了", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(MainActivity.this,MovieActivity.class);
                        intent.putExtra("URL", Constant.URL);
                        startActivity(intent);
                        break;
                }
            }
        });
    }
}
