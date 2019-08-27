package com.goisan.common.transcoding;

import java.io.File;
import java.io.IOException;

public class Transcoding {

    private static String path = new File(Transcoding.class.getClassLoader().getResource("")
            .getPath().toString()).getParent();

    /**
     * 视频转码
     *
     * @param in  需要转码的视频，绝对路径，有后缀
     * @param out 转码后视频，绝对路径，无后缀
     */
    public static void transcoding(String in, String out) {
        String cmd = "cmd /c start " + path + "/lib/mencoder.bat %s %s.mp4";
        try {
            Runtime.getRuntime().exec(String.format(cmd, in, out));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
