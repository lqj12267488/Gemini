package com.goisan.common;

import java.text.DecimalFormat;

/**
 * Created by admin on 2017/12/6.
 */

public class ResourcelibraryCommonUtil {

    public static String fileSize(long fileSize){
        String size = "";
        DecimalFormat df=new DecimalFormat("0.00");
        if(fileSize < 1000){// B
            size = fileSize +" B";
        }else if(fileSize/1000/1024 < 1){// KB
            size = df.format((fileSize/1024))+" KB";
        }else if(fileSize/1000/1024/1024 < 1 ){// MB
            size = df.format(fileSize/1024/1024)+" MB";
        }else if(fileSize/1000/1024/1024/1024 < 1){// GB
            size = df.format(fileSize/1024/1024/1024)+" GB";
//        }else if(fileSize < 1000*1024*1024*1024*1024){// TB
        }else {// TB
            size = df.format(fileSize/1024/1024/1024/1024)+" TB";
//        }else if(fileSize < 1000*1024*1024*1024*1024*1024){// PB
//            size = df.format(fileSize/1024/1024/1024/1024/1024)+" PB";
        }
        return size;
    }

    public static String getFilesThumbnailURL(String resourceFormat , String type){
            String uploadFiles ="";
        if(resourceFormat.equals("5")){
            // 动画   5
            uploadFiles = "../../libs/img/resourcelibrary/thumbnail/dh.jpg";
        }else if (resourceFormat.equals("1") || ".txt.pdf.chm.wdl.doc.docx.dotx.xls.xlsx.".indexOf("." + type + ".") != -1) {
            // 文档   1
            uploadFiles = "../../libs/img/resourcelibrary/thumbnail/wd.jpg";
        }else if (resourceFormat.equals("2") || ".bmp.jpg.png.tiff.gif.pcx.tga.exif.fpx.svg.psd.cdr.pcd.dxf.ufo.eps.ai.raw.wmf.".indexOf("." + type + ".") != -1) {
            //  图片  2
            uploadFiles = "../../libs/img/resourcelibrary/thumbnail/tp.jpg";
        }else if (resourceFormat.equals("3") || ".cd.ogg.mp3.asf.wma.wav.mp3.pro.rm.real.ape.module.midi.vqf.".indexOf("." + type + ".") != -1) {
            // 音频   3
            uploadFiles = "../../libs/img/resourcelibrary/thumbnail/yp.jpg";
        }else if (resourceFormat.equals("4") || ".mp4.avi.wmv.mpeg.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + type + ".") != -1) {
            // 视频	4
            uploadFiles = "../../libs/img/resourcelibrary/thumbnail/sp.jpg";
        }else {
            // 其他	9
            uploadFiles = "../../libs/img/resourcelibrary/thumbnail/qt.jpg";
        }
        return uploadFiles;
    }
}
