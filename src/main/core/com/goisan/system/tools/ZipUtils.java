package com.goisan.system.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZipUtils {

    private static final int BUFFER_SIZE = 2 * 1024;

    private ZipUtils() {
    }

    /**
     * 压缩成ZIP 方法1
     *
     * @param srcDir           压缩文件夹路径
     * @param out              压缩文件输出流
     * @param keepDirStructure 是否保留原来的目录结构,true:保留目录结构;
     *                         false:所有文件跑到压缩包根目录下(注意：不保留目录结构可能会出现同名文件,会压缩失败)
     */
    public static void toZip(String srcDir, OutputStream out, boolean keepDirStructure) {

        try (ZipOutputStream zos = new ZipOutputStream(out)) {
            File sourceFile = new File(srcDir);
            compress(sourceFile, zos, sourceFile.getName(), keepDirStructure);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 压缩成ZIP 方法2
     *
     * @param srcFiles 需要压缩的文件列表
     * @param out      压缩文件输出流
     */
    public static void toZip(List<File> srcFiles, OutputStream out) {

        try (ZipOutputStream zos = new ZipOutputStream(out)) {
            for (File srcFile : srcFiles) {
                byte[] buf = new byte[BUFFER_SIZE];
                zos.putNextEntry(new ZipEntry(srcFile.getName()));
                int len;
                FileInputStream in = new FileInputStream(srcFile);
                while ((len = in.read(buf)) != -1) {
                    zos.write(buf, 0, len);
                }
                zos.closeEntry();
                in.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    /**
     * 递归压缩方法
     *
     * @param sourceFile       源文件
     * @param zos              zip输出流
     * @param name             压缩后的名称
     * @param keepDirStructure 是否保留原来的目录结构,true:保留目录结构;
     *                         false:所有文件跑到压缩包根目录下(注意：不保留目录结构可能会出现同名文件,会压缩失败)
     * @throws Exception
     */
    private static void compress(File sourceFile, ZipOutputStream zos, String name, boolean keepDirStructure) throws Exception {

        if (sourceFile.isFile()) {
            byte[] buf = new byte[BUFFER_SIZE];
            zos.putNextEntry(new ZipEntry(name));
            int len;
            FileInputStream in = new FileInputStream(sourceFile);
            while ((len = in.read(buf)) != -1) {
                zos.write(buf, 0, len);
            }
            zos.closeEntry();
            in.close();
            return;
        }
        File[] listFiles = sourceFile.listFiles();
        if (listFiles == null || listFiles.length == 0) {
            if (keepDirStructure) {
                zos.putNextEntry(new ZipEntry(name + "/"));
                zos.closeEntry();
            }
        } else {
            for (File file : listFiles) {
                if (keepDirStructure) {
                    compress(file, zos, name + "/" + file.getName(), keepDirStructure);
                } else {
                    compress(file, zos, file.getName(), keepDirStructure);
                }
            }
        }
    }

}
