/**********************************
 keywe spooncms version [1.0]

 Copyright ⓒ 2015 keywesoft Inc. All rights reserved.

 This is a proprietary software of kt Inc. and you may not use this file except in
 compliance with license agreement with kt Inc. Any redistribution or use of this
 software, with or without modification shall be strictly prohibited without prior
 written approval of kt Inc. and the copyright notice above does not evidence any
 actual or intended publication of such software.
 *********************************/
package com.kabone.research.common.utils;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @author sun
 *
 */
public class FileUtil {
	private static final Logger logger = LoggerFactory.getLogger(FileUtil.class);

//	public final static String BUCKET_NAME = "fintech.data";		//SVC
//	public final static String BUCKET_NAME = "fintech.data.dev";	//DEV
//	public final static String S3_ENDPOINT = "s3-ap-northeast-1.amazonaws.com";
//	public static String ACCESS_KEY            = "AKIAJZV7QLIBFUZUOIMQ";
//	public static String SECRET_KEY            = "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";





	/**
	 * 파일정보
	 * @param map
	 * @param realPath
	 * @param dirPath
	 * @param thumbnail
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	public static List<Map<String,Object>> getFileInfo(MultiValueMap<String, MultipartFile> map, String realPath, String dirPath, boolean thumbnail) throws IllegalStateException, IOException {

		Date time = Calendar.getInstance().getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssS");
        String formatDate = formatter.format(time);

        List<Map<String,Object>> fileList = new ArrayList<Map<String, Object>>();

        Iterator<String> iterator = map.keySet().iterator();

        // 넘어온 savePath 에 /yyyy/mm/ 두개의 디렉토리 추가 설정
        String savePath = dirPath + File.separator + StringUtils.substring(formatDate, 0, 4) + File.separator + StringUtils.substring(formatDate, 4, 6) + File.separator;

        String realFilePath = realPath + savePath;
        String logicalPath = savePath;

        if(File.separator.equalsIgnoreCase("\\")) {
            logicalPath = savePath.replaceAll("\\\\", "/");
        }

        while(iterator.hasNext()) {

        	Map<String, Object> fileMap = new HashMap<String, Object>();

            String key = iterator.next();
            LinkedList<MultipartFile> df = (LinkedList<MultipartFile>) map.get(key);

            CommonsMultipartFile fileInfo = (CommonsMultipartFile) df.getFirst();
            if(fileInfo.getSize() > 0) {
            	fileMap.put("key", key);

        		int idx = fileInfo.getOriginalFilename().lastIndexOf(".");

        		String extName = "";
        		if( idx != -1 ) {
        			extName = fileInfo.getOriginalFilename().substring( idx, fileInfo.getOriginalFilename().length() );
        		}

        		File fDir = new File(realFilePath);
        		if(!fDir.exists()){
        			fDir.mkdirs();
        		}

        		File file1 = new File(realFilePath + formatDate + fileInfo.getName() + extName);
    			fileInfo.transferTo(file1);

    			logger.info("fileInfo.realFilePath() : " + realFilePath);
    			logger.info("fileInfo.logicalPath() : " + logicalPath);
    			logger.info("fileInfo.getOriginalFilename() : " + fileInfo.getOriginalFilename());
    			logger.info("fileInfo.getName() : " + fileInfo.getName());
    			logger.info("fileInfo.path() : " + logicalPath + formatDate + fileInfo.getName() + extName);

    			fileMap.put("path", logicalPath + formatDate + fileInfo.getName() + extName);
    			fileMap.put("name", fileInfo.getOriginalFilename());
    			fileMap.put("size", "" + fileInfo.getSize());

    			//썸네일
    			if(thumbnail) {
	    			int imageWidth = 0;
	    			int imageHeight = 0;
	    			//프로젝트 등록시 썸네일 생성
	    			if("mainImg".equals(fileInfo.getName())) {
	    				logger.info("메인 이미지 썸네일 생성");
	    				imageWidth = 645;
	    				imageHeight = 485;
	    			} else if("cardImg".equals(fileInfo.getName())) {
	    				logger.info("카드 이미지 썸네일 생성");
	    				imageWidth = 240;
	    				imageHeight = 180;
	    			}

	    			if(imageWidth != 0 && imageHeight != 0) {
	    				File originFileName = new File(realFilePath + formatDate + fileInfo.getName() + extName);
	        			File thumbFileName = new File(realFilePath + "thumbnail_" + formatDate + fileInfo.getName() + extName);

	        			thumbnail(imageWidth, imageHeight, originFileName, thumbFileName);

	        			fileMap.put("thumb", logicalPath + "thumbnail_" + formatDate + fileInfo.getName() + extName);
	    			}
    			}
    			fileList.add(fileMap);
            }

        }

		return fileList;
	}

	public static List<Map<String,Object>> getFileInfo2(String BUCKET_NAME, String S3_ENDPOINT, String ACCESS_KEY, String SECRET_KEY, MultiValueMap<String, MultipartFile> map, String realPath, String dirPath, boolean thumbnail) throws Exception {
	//public static List<Map<String,Object>> getFileInfo2(MultiValueMap<String, MultipartFile> map, String realPath, String dirPath, boolean thumbnail) throws Exception {

		Date time = Calendar.getInstance().getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssS");
        String formatDate = formatter.format(time);

        List<Map<String,Object>> fileList = new ArrayList<Map<String, Object>>();
        Iterator<String> iterator = map.keySet().iterator();

        String savePath = dirPath + "/";

        String realFilePath = realPath + savePath;
        /*
        String logicalPath = savePath;

        if(File.separator.equalsIgnoreCase("\\")) {
            logicalPath = savePath.replaceAll("\\\\", "/");
        }
        */
        File fDir = new File(realFilePath);
		if(!fDir.exists()){
			fDir.mkdirs();
		}

		AWSUtil.s3MakeFolder(S3_ENDPOINT, BUCKET_NAME, ACCESS_KEY, SECRET_KEY, dirPath);

        while(iterator.hasNext()) {

        	Map<String, Object> fileMap = new HashMap<String, Object>();

            String key = iterator.next();
            LinkedList<MultipartFile> df = (LinkedList<MultipartFile>) map.get(key);

            CommonsMultipartFile fileInfo = (CommonsMultipartFile) df.getFirst();
            if(fileInfo.getSize() > 0) {
            	fileMap.put("key", key);

        		int idx = fileInfo.getOriginalFilename().lastIndexOf(".");

        		String extName = "";
        		if( idx != -1 ) {
        			extName = fileInfo.getOriginalFilename().substring( idx, fileInfo.getOriginalFilename().length() );
        		}
        		String fileName = formatDate + fileInfo.getName() + extName;
        		File file1 = new File(realFilePath + fileName);
        		fileInfo.transferTo(file1);

    			logger.info("fileInfo.getOriginalFilename() : " + fileInfo.getOriginalFilename());

        		String filePath = AWSUtil.s3FileUpload(S3_ENDPOINT, BUCKET_NAME, ACCESS_KEY, SECRET_KEY, savePath + fileName, realFilePath + fileName);

        		logger.info("filePath : " + filePath);

    			fileMap.put("path", filePath);
    			fileMap.put("name", fileInfo.getOriginalFilename());
    			fileMap.put("size", "" + fileInfo.getSize());

    			//썸네일
    			if(thumbnail) {
	    			int imageWidth = 0;
	    			int imageHeight = 0;
	    			//프로젝트 등록시 썸네일 생성
	    			if("mainImg".equals(fileInfo.getName())) {
	    				//메인이미지
	    				imageWidth = 645;
	    				imageHeight = 485;
	    			} else if("cardImg".equals(fileInfo.getName())) {
	    				//카드이미지
	    				imageWidth = 224;
	    				imageHeight = 180;
	    			} else if("storyImg".equals(fileInfo.getName())) {
	    				//스토리
	    				imageWidth = 148;
	    				imageHeight = 98;
	    			} else if("ftypeMainImg".equals(fileInfo.getName())) {
	    				//기금형 메인이미지
	    				imageWidth = 980;
	    				imageHeight = 400;
	    			} else if("choiceImg".equals(fileInfo.getName())) {
	    				// Editor's Choice 이미지
	    				imageWidth = 160;
	    				imageHeight = 70;
	    			}

	    			if(imageWidth != 0 && imageHeight != 0) {
	    				File originFileName = new File(realFilePath + fileName);
	        			File thumbFileName = new File(realFilePath + "thumbnail_" + fileName);

	        			boolean result = thumbnail(imageWidth, imageHeight, originFileName, thumbFileName);
	        			String filePath2 = "";
	        			if(result) {
	        				filePath2 = AWSUtil.s3FileUpload(S3_ENDPOINT, BUCKET_NAME, ACCESS_KEY, SECRET_KEY, savePath + "thumbnail_" + fileName, realFilePath + "thumbnail_" + fileName);
	        			}

	        			if(thumbFileName.exists()){
	        				thumbFileName.delete();
	                    }

	        			fileMap.put("thumbPath", filePath2);
	    			}
    			}

    			if(file1.exists()){
                    file1.delete();
                }

    			fileList.add(fileMap);
            }

        }

		return fileList;
	}


    /**
     * 파일정보
     * @param map
     * @param realPath
     * @param dirPath
     * @return
     * @throws IllegalStateException
     * @throws IOException
     */
    public static List<Map<String,Object>> getFileInfo(MultiValueMap<String, MultipartFile> map,String realPath, String dirPath) throws IllegalStateException, IOException{
        return getFileInfo(map, realPath, dirPath, false);
    }

	public static boolean thumbnail(int imageWidth , int imageHeight, File originFileName, File thumbFileName) {
		boolean result = false;
		try {
			BufferedImage bufferOriginImg = ImageIO.read(originFileName);
			BufferedImage bufferThumbImg = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = bufferThumbImg.createGraphics();
			graphic.drawImage(bufferOriginImg, 0, 0, imageWidth, imageHeight, null);
			ImageIO.write(bufferThumbImg, "jpg", thumbFileName);
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		}

		return result;
	}

    /**
     * 파일타입
     * @param file
     * @return
     */
    protected static String getFileType (File file) {
        InputStream inputStream = null;
        byte[] buf = new byte[132];
        try {
            inputStream = new FileInputStream(file);
            inputStream.read(buf, 0, 132);
        } catch (IOException ioexception) {
            return "UNKNOWN";
        } finally {
            if (inputStream != null) {
				try { inputStream.close(); } catch (Exception exception) {}
			}
        }

        int b0 = buf[0] & 255;
        int b1 = buf[1] & 255;
        int b2 = buf[2] & 255;
        int b3 = buf[3] & 255;

        if (buf[128] == 68 && buf[129] == 73 && buf[130] == 67 && buf[131] == 77 && ((b0 == 73 && b1 == 73) || (b0 == 77 && b1 == 77))) {
			return "TIFF_AND_DICOM";
		}
        if (b0 == 73 && b1 == 73 && b2 == 42 && b3 == 0) {
			return "TIFF";
		}
        if (b0 == 77 && b1 == 77 && b2 == 0 && b3 == 42) {
			return "TIFF";
		}
        if (b0 == 255 && b1 == 216 && b2 == 255) {
			return "JPEG";
		}
        if (b0 == 71 && b1 == 73 && b2 == 70 && b3 == 56) {
			return "GIF";
		}
        if (buf[128] == 68 && buf[129] == 73 && buf[130] == 67 && buf[131] == 77) {
			return "DICOM";
		}
        if (b0 == 8 && b1 == 0 && b3 == 0) {
			return "DICOM";
		}
        if (b0 == 83 && b1 == 73 && b2 == 77 && b3 == 80) {
			return "FITS";
		}
        if (b0 == 80 && (b1 == 50 || b1 == 53) && (b2 == 10 || b2 == 13 || b2 == 32 || b2 == 9)) {
			return "PGM";
		}
        if ( b0 == 66 && b1 == 77) {
			return "BMP";
		}
        if (b0 == 73 && b1 == 111) {
			return "ROI";
		}
        if (b0 >= 32 && b0 <= 126 && b1 >= 32 && b1 <= 126 && b2 >= 32 && b2 <= 126 && b3 >= 32 && b3 <= 126 && buf[8] >= 32 && buf[8] <= 126) {
			return "TEXT";
		}
        if (b0 == 137 && b1 == 80 && b2 == 78 && b3 == 71) {
			return "PNG";
		}

        return "UNKNOWN";
    }
}
