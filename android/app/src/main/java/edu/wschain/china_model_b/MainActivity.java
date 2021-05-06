package edu.wschain.china_model_b;

import android.Manifest;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;

import android.hardware.fingerprint.FingerprintManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.CancellationSignal;

import android.util.Log;
import android.view.ContextThemeWrapper;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import androidx.appcompat.app.AlertDialog;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;


import java.util.ArrayList;
import java.util.List;

import edu.wschain.china_model_b.Utils.Constant;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import static android.provider.Settings.ACTION_SETTINGS;

public class MainActivity extends FlutterActivity {

    private static final String TAG = "Main";
    private List<String> mPermissionList = new ArrayList<>();
    private String[] permission = new String[]{Manifest.permission.CALL_PHONE, Manifest.permission.USE_FINGERPRINT};
    //    private List<String> permissionList = [Manifest.permission.CALL_PHONE];
    private final int mRequestCode = 100;//权限请求码
    private boolean isPermission = false;
    private String methodName = "";
    private FingerprintManager fingerprintManager;
    private AlertDialog.Builder alertBuilder;
    private AlertDialog alertDialog;
    private CancellationSignal cancellationSignal;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterView(), "android").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                switch (call.method) {
                    case "movieTest":
                        Toast.makeText(MainActivity.this, "长按了", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(MainActivity.this, MovieActivity.class);
                        intent.putExtra("URL", Constant.URL);
                        startActivity(intent);
                        break;
                    case "movieToast":
                        Toast.makeText(MainActivity.this, "一次最多可购五张票", Toast.LENGTH_SHORT).show();
                        break;
                    case "permission":
                        initPermission();
                        break;
                    case "call":
                        callPhone();
                        break;
                    case "finger":
                        getPrinter();
                        break;
                }
            }
        });
    }


    //判断指纹
    private void getPrinter() {
        if (supportFingerPrint()) {
            if (Build.VERSION.SDK_INT > 23) {
                Toast.makeText(this, "请输入指纹", Toast.LENGTH_SHORT).show();
                cancellationSignal = new CancellationSignal(); //取消监听
                showAlertDialog("输入指纹","请输入指纹",false);

                fingerprintManager.authenticate(null, cancellationSignal, 0, new FingerprintManager.AuthenticationCallback() {
                    @Override
                    public void onAuthenticationError(int errorCode, CharSequence errString) {
                        super.onAuthenticationError(errorCode, errString);
                        Toast.makeText(MainActivity.this, errString, Toast.LENGTH_SHORT).show();

                        Log.i(TAG, "errorCode: " + errorCode);
                        Log.i(TAG, "errString: " + errString);

                        alertDialog.dismiss();

                    }

                    @Override
                    public void onAuthenticationHelp(int helpCode, CharSequence helpString) {
                        super.onAuthenticationHelp(helpCode, helpString);
                        Toast.makeText(MainActivity.this, helpString, Toast.LENGTH_SHORT).show();
                        Log.i(TAG, "helpCode: " + helpCode);
                        Log.i(TAG, "helpString: " + helpString);
                    }

                    @Override
                    public void onAuthenticationSucceeded(FingerprintManager.AuthenticationResult result) {
                        super.onAuthenticationSucceeded(result);
                        Toast.makeText(MainActivity.this, "指纹认证成功", Toast.LENGTH_SHORT).show();
                        alertDialog.dismiss();
                    }

                    @Override
                    public void onAuthenticationFailed() {
                        super.onAuthenticationFailed();
                        Toast.makeText(MainActivity.this, "认证失败，请再试一次", Toast.LENGTH_SHORT).show();
                    }
                }, null);

            }
        }
    }


    private boolean supportFingerPrint() {
        if (Build.VERSION.SDK_INT < 23) {
            Toast.makeText(this, "您的版本过低，不支持指纹解锁", Toast.LENGTH_SHORT).show();
            return false;
        } else {
            fingerprintManager = getSystemService(FingerprintManager.class);
            if (!fingerprintManager.isHardwareDetected()) {
                Toast.makeText(this, "您的手机不支持指纹", Toast.LENGTH_SHORT).show();
                return false;
            } else if (!fingerprintManager.hasEnrolledFingerprints()) {
                Toast.makeText(this, "您至少需要在系统设置中添加一个指纹", Toast.LENGTH_SHORT).show();


                showAlertDialog("提示","是否需要跳转到设置界面",true);

                return false;

//                Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
//
//                Uri uri = Uri.fromParts("package", getPackageName(), null);
//
//                intent.setData(uri);
//                startActivity(intent);
            }
        }
        return true;
    }


    //
    private void showAlertDialog(String title, String message, boolean isNeedButton) {
        alertBuilder = new AlertDialog.Builder(new ContextThemeWrapper(this, R.style.LaunchTheme3));
        alertBuilder.setTitle(title).setMessage(message).setIcon(R.drawable.ic_baseline_fingerprint_24);
        if (isNeedButton) {
            alertBuilder.setPositiveButton("确定", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    intentSettings();
//                        dialog.cancel();
                }
            });
            alertBuilder.setNegativeButton("取消", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {

                }
            });
        }
        alertBuilder.create();
        alertDialog = alertBuilder.show();


        //监听弹窗没有的时候
        alertDialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
            @Override
            public void onDismiss(DialogInterface dialog) {
                System.out.println("取消了");
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    cancellationSignal.cancel();
                }
            }
        });
    }


    //跳转到设置界面
    private void intentSettings() {
        Intent intent = new Intent(ACTION_SETTINGS);
        startActivity(intent);
    }


    private void callPhone() {
        methodName = "call";
        if (Build.VERSION.SDK_INT >= 23) {
            if (initPermission()) {
                callMethod();
            }
        } else {
            callMethod();
        }
    }

    private void callMethod() {
        String number = "1338170249";
        Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + number));
        startActivity(intent);
    }

    private boolean initPermission() {

        mPermissionList.clear();

        //逐个判断你要的权限是否打开
        for (int i = 0; i < permission.length; i++) {
            if (ContextCompat.checkSelfPermission(this, permission[i]) != PackageManager.PERMISSION_GRANTED) {
                mPermissionList.add(permission[i]); //添加没有授权的权限
            }
        }

        if (mPermissionList.size() > 0) { //有 没有通过的权限
            ActivityCompat.requestPermissions(this, permission, mRequestCode);
            return isPermission;
        } else {
            isPermission = true;
        }
//        else {
//            callMethod();
//        }

        return isPermission;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        boolean isTrue = false; //有权限没有通过
        if (mRequestCode == requestCode) {
            for (int i = 0; i < grantResults.length; i++) {
                if (grantResults[i] == -1) {
                    isTrue = true;
                }
            }
        }
        if (isTrue) {
            //还是有没有通过的，可以通过用户指示跳转到设置界面
            Toast.makeText(this, "请同意权限", Toast.LENGTH_SHORT).show();
        } else {
            if (methodName.equals("call")) {
                callMethod();
            }
        }
//        else {
//            callMethod();
//        }
    }
}
