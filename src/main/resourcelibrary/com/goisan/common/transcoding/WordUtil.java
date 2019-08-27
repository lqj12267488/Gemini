package com.goisan.common.transcoding;

import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.dao.ResourceFilesDao;
import org.jodconverter.OfficeDocumentConverter;
import org.jodconverter.office.DefaultOfficeManagerBuilder;
import org.jodconverter.office.OfficeException;
import org.jodconverter.office.OfficeManager;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.*;
import java.util.List;
import java.util.Properties;

@Component
@Scope("singleton")
public class WordUtil {
    private DefaultOfficeManagerBuilder OfficeManagerBuilder;
    private OfficeManager manager;
    private OfficeDocumentConverter converter;
    @Resource
    private ResourceFilesDao resourceFilesDao;

    /**
     * 开启libreoffice转码服务
     * 需要在config.properties配置officeHome和portNumber
     * officeHome:libreoffice路径，不要带有中文路径，如果带有中文路径需将中文转为ASCII码
     * portNumber:开启服务的端口
     */
    public void init() {
        OfficeManagerBuilder = new DefaultOfficeManagerBuilder();
        final Properties properties = new Properties();
        FileInputStream in = null;
        try {
            in = new FileInputStream(this.getClass().getResource("/").getPath() + "/config.properties");
            properties.load(in);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        if ("true".equals(properties.getProperty("isUseOffice"))) {
            final long sleepTime = Long.parseLong(properties.getProperty("sleepTime"));
            OfficeManagerBuilder.setOfficeHome(properties.getProperty("officeHome"));
            OfficeManagerBuilder.setPortNumber(Integer.parseInt(properties.getProperty("portNumber")));
            if (manager == null) {
                manager = OfficeManagerBuilder.build();
            }
            try {
                if (!manager.isRunning()) {
                    manager.start();
                }
                if (converter == null) {
                    converter = new OfficeDocumentConverter(manager);
                }
                Thread t = new Thread() {
                    public void run() {
                        while (true) {
                            List<ResourceFiles> resourceFiles = getFiles();
                            for (ResourceFiles resourceFile : resourceFiles) {
                                wordToPdf(resourceFile);
                            }
                            try {
                                Thread.sleep(sleepTime);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                };
                t.start();
            } catch (OfficeException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 转码
     * 如果是.txt先将txt转为utf-8后转码
     * 会生成新的文件，转为pdf后删，并更新数据库中转码状态
     *
     * @param resourceFile
     */

    public void wordToPdf(ResourceFiles resourceFile) {
        String path = new File(this.getClass().getResource("/").getPath()).getParentFile().getParentFile().getPath();
        //要转码的文件路径
        String in = path + resourceFile.getFileUrl();
        String ext = in.substring(in.lastIndexOf("."), in.length()).toLowerCase();
        //转码后的文件路径
        String out = in.substring(0, in.lastIndexOf(".")) + ".pdf";
        try {
            if (!".pdf".equals(ext)) {
                if (".txt".equals(ext)) {
                    //将txt字符集转为utf-8，并返回新文件路径
                    in = deCode(in, checkCharset(in));
                }
                //转码
                converter.convert(new File(in), new File(out));
            }
            //如果是txt删除转为utf-8的文件
            if (".txt".equals(ext)) {
                new File(in).delete();
            }
            resourceFilesDao.updateResourceFileStatus(resourceFile.getFileId(), 1);
        } catch (Exception e) {
            //出现异常将当前文件数据库中改为转码失败状态
            resourceFilesDao.updateResourceFileStatus(resourceFile.getFileId(), 2);
            e.printStackTrace();
        }
    }
    public void wordToPdf(String inPath) {
        OfficeManagerBuilder = new DefaultOfficeManagerBuilder();
        final Properties properties = new Properties();
        FileInputStream in = null;
        try {
            in = new FileInputStream(this.getClass().getResource("/").getPath() + "/config.properties");
            properties.load(in);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        OfficeManagerBuilder.setOfficeHome(properties.getProperty("officeHome"));
        OfficeManagerBuilder.setPortNumber(Integer.parseInt(properties.getProperty("portNumber")));
        if (manager == null) {
            manager = OfficeManagerBuilder.build();
        }
        try {
            if (!manager.isRunning()) {
                manager.start();
            }
            if (converter == null) {
                converter = new OfficeDocumentConverter(manager);
            }
        } catch (OfficeException e) {
            e.printStackTrace();
        }
        String ext = inPath.substring(inPath.lastIndexOf("."), inPath.length()).toLowerCase();
        //转码后的文件路径
        String out = inPath.substring(0, inPath.lastIndexOf(".")) + ".pdf";
        try {
            if (!".pdf".equals(ext)) {
                if (".txt".equals(ext)) {
                    //将txt字符集转为utf-8，并返回新文件路径
                    inPath = deCode(inPath, checkCharset(inPath));
                }
                //转码
                converter.convert(new File(inPath), new File(out));
            }
            //如果是txt删除转为utf-8的文件
            if (".txt".equals(ext)) {
                new File(inPath).delete();
            }
        } catch (Exception e) {
            //出现异常将当前文件数据库中改为转码失败状态
            e.printStackTrace();
        }
    }

    /**
     * 判断txt文件的字符集
     * 这个我也不懂在2.0扒的
     *
     * @param in
     * @return
     */
    public String checkCharset(String in) {
        BufferedInputStream bin = null;
        String code = null;
        try {
            bin = new BufferedInputStream(new FileInputStream(new File(in)));
            int p = (bin.read() << 8) + bin.read();
            switch (p) {
                case 0xefbb:
                    code = "UTF-8";
                    break;
                case 0xfffe:
                    code = "Unicode";
                    break;
                case 0xfeff:
                    code = "UTF-16BE";
                    break;
                default:
                    code = "GBK";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                bin.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return code;
    }

    /**
     * 将txt转为utf-8
     *
     * @param in
     * @param code
     * @return
     */
    private String deCode(String in, String code) {
        BufferedReader reader = null;
        BufferedWriter writer = null;
        if (!"utf-8".equals(code.toLowerCase())) {
            try {
                File file = new File(in);
                if (file.isFile() && file.exists()) {
                    reader = new BufferedReader(new InputStreamReader(new FileInputStream(in), code));
                    in = in.substring(0, in.lastIndexOf(".")) + "_decode.txt";
                    writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(in), "UTF-8"));
                    String line = "";
                    while ((line = reader.readLine()) != null) {
                        writer.write(line);
                        writer.newLine();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    reader.close();
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return in;
    }

    public List<ResourceFiles> getFiles() {
        return resourceFilesDao.getUnDeDodeWord();
    }

}
