package com.goisan.system.bean;

import java.io.File;

public class PathBean {
	public static String BASEPATH = "";
	public static String CONTEXT = "";
	public static String WEBINF = "WEB-INF";
	public static final String CONFIGDIR = "config";

	public static String TEMPLATEPATH;

	//模板
	public final static String TEMPLATE_PATH = "template";
	//文件上传
	public final static String UPLOAD_PATH = "upload";

	public static void init(){
		TEMPLATEPATH = BASEPATH  + File.separator + TEMPLATE_PATH;
	}
}
