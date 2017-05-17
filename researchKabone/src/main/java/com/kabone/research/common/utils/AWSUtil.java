package com.kabone.research.common.utils;

import java.io.File;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

// aws-java-sdk-1.10.12.jar
import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.HttpMethod;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.transfer.TransferManager;
import com.amazonaws.services.s3.transfer.Upload;

/**
 * @author 
 *
 * AWS 연동 관련  Component
 */
public class AWSUtil {

	private final static String BUCKET 			= "fintech.data";
	private final static String BUCKET_DEV 		= "fintech.data.dev";
	private final static String S3_ENDPOINT 	= "s3-ap-northeast-1.amazonaws.com";
	private final static String ACCESS_KEY  	= "AKIAJZV7QLIBFUZUOIMQ";
	private final static String SECRET_KEY		= "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";  
	private final static String FOLDER_SUFFIX 	= "/";
	
	
	/**
     * aws s3 상용 bucket에 파일을 올린다.
     * @param existingBucketName  S3 버켓명
     * @param keyName 업로드될 이름
     * @param filePath 업로드할 파일 경로
     * @return S3접근URL String
     * @throws IOException
     */
	public static String s3FileUpload(String existingBucketName, String keyName, String filePath) throws Exception
	{
		String result = "";
		   
		AWSCredentials credential = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
		AmazonS3 s3 = new AmazonS3Client(credential); 
	        
		PutObjectRequest putObjectRequest = new PutObjectRequest(existingBucketName, keyName, new File(filePath));
		putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
		//putRequest.setCannedAcl(CannedAccessControlList.PublicReadWrite);
	        
		s3.putObject(putObjectRequest);
		
		result =   "https://" + S3_ENDPOINT + "/" + existingBucketName + "/" + keyName;
	    
	    return result;
	}
	
	
	/**
     * aws s3 상용 bucket에 파일을 올린다.
     * @param accessKey AWS S3 Access Key
     * @param secretKey AWS S3 Secret Key
     * @param keyName 업로드될 이름
     * @param filePath 업로드할 파일 경로
     * @return S3접근URL String
     * @throws IOException
     */
	public static String s3FileUpload(String accessKey, String secretKey, String keyName, String filePath) throws Exception
	{
		String result = "";
		   
		AWSCredentials credential = new BasicAWSCredentials(accessKey, secretKey);
		AmazonS3 s3 = new AmazonS3Client(credential); 
	        
		PutObjectRequest putObjectRequest = new PutObjectRequest(BUCKET, keyName, new File(filePath));
		putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
		//putRequest.setCannedAcl(CannedAccessControlList.PublicReadWrite);
	        
		s3.putObject(putObjectRequest);
		
		result =  "https://" + S3_ENDPOINT + "/" + BUCKET + "/" + keyName;
	    
	    return result;
	}
	
	/**
     * aws s3 상용 bucket에 파일을 올린다.
     * @param endpoint AWS S3 Endpoint
     * @param accessKey AWS S3 Access Key
     * @param secretKey AWS S3 Secret Key
     * @param existingBucketName  S3 버켓명
     * @param keyName 업로드될 이름
     * @param filePath 업로드할 파일 경로
     * @return S3접근URL String
     * @throws IOException
     */
	public static String s3FileUpload(String endpoint, String existingBucketName, String accessKey, String secretKey, String keyName, String filePath) throws Exception
	{
		String result = "";
		   
		AWSCredentials credential = new BasicAWSCredentials(accessKey, secretKey);
		AmazonS3 s3 = new AmazonS3Client(credential); 
	        
		PutObjectRequest putObjectRequest = new PutObjectRequest(existingBucketName, keyName, new File(filePath));
		putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
		//putRequest.setCannedAcl(CannedAccessControlList.PublicReadWrite);
	        
		s3.putObject(putObjectRequest);
		
		result =   "https://" + endpoint + "/" + existingBucketName + "/" + keyName;
	    
	    return result;
	}
	
	/**
     * aws s3 bucket에 파일을 올린다.
     * @param endpoint AWS S3 endpoint
     * @param existBucketName S3 bucket name
     * @param accessKey AWS S3 Access Key
     * @param secretKey AWS S3 Secret Key
     * @param keyName 업로드될 이름
     * @param filePath 업로드할 파일 경로
     * @return S3접근URL String
     * @throws IOException
     */
	public static String s3FileUpload2(String endpoint, String existingBucketName, String accessKey, String secretKey, String keyName, String filePath) throws Exception
	{
		String result = "";
		TransferManager tm = new TransferManager(new BasicAWSCredentials(accessKey, secretKey));
	    //System.out.println("Hello");
	    //TransferManager processes all transfers asynchronously, 
	    // so this call will return immediately.
	    Upload upload = tm.upload(existingBucketName, keyName, new File(filePath));
	    //System.out.println("Hello2");

	    try {
	    	//Or you can block and wait for the upload to finish
	    	upload.waitForCompletion();
	    	//System.out.println("Upload complete.");
	    } catch (InterruptedException e) {
	    	// TODO Auto-generated catch block
	    	e.printStackTrace();
	    } catch (AmazonClientException amazonClientException) {
	    	System.out.println("Unable to upload file, upload was aborted.");
	    	amazonClientException.printStackTrace();
	    }
	 
	    result = "https://" + endpoint + "/" + existingBucketName + "/" + keyName;
	    
	    return result;
	}
	
	/**
     * aws s3 bucket에 폴더를 생성한다.
     * @param endpoint AWS S3 endpoint
     * @param existBucketName S3 bucket name
     * @param accessKey AWS S3 Access Key
     * @param secretKey AWS S3 Secret Key
     * @param folderName 폴더 이름
     * @return S3접근URL String
     * @throws IOException
     */
	public static String s3MakeFolder(String endpoint, String existingBucketName, String accessKey, String secretKey, String folderName) throws Exception
	{
		String result = "";
	    
	    AWSCredentials credential = new BasicAWSCredentials(accessKey, secretKey);
	    AmazonS3 s3 = new AmazonS3Client(credential); 
        
	    // Create metadata for your folder & set content-length to 0 
	    ObjectMetadata metadata = new ObjectMetadata(); 
	    metadata.setContentLength(0); 

	    // Create empty content 
	    InputStream emptyContent = new ByteArrayInputStream(new byte[0]); 

	    // Create a PutObjectRequest passing the foldername suffixed by / 
	    PutObjectRequest putObjectRequest =  new PutObjectRequest(existingBucketName, folderName + FOLDER_SUFFIX, emptyContent, metadata); 

	    // Send request to S3 to create folder 
	    s3.putObject(putObjectRequest); 

	    result = "https://" + endpoint + "/" + existingBucketName + "/" + folderName;

	    return result;
	}
	
	/**
     * aws s3 bucket에 폴더를 생성한다.
     * @param accessKey AWS S3 Access Key
     * @param secretKey AWS S3 Secret Key
     * @param folderName 폴더 이름
     * @return S3접근URL String
     * @throws IOException
     */
	public static String s3MakeFolder(String accessKey, String secretKey, String folderName) throws Exception
	{
		String result = "";
	    
		AWSCredentials credential = new BasicAWSCredentials(accessKey, secretKey);
	    AmazonS3 s3 = new AmazonS3Client(credential); 
        
	    // Create metadata for your folder & set content-length to 0 
	    ObjectMetadata metadata = new ObjectMetadata(); 
	    metadata.setContentLength(0); 
	    
	    // Create empty content 
	    InputStream emptyContent = new ByteArrayInputStream(new byte[0]); 

	    // Create a PutObjectRequest passing the foldername suffixed by / 
	    PutObjectRequest putObjectRequest =  new PutObjectRequest(BUCKET, folderName + FOLDER_SUFFIX, emptyContent, metadata); 

	    // Send request to S3 to create folder 
	    s3.putObject(putObjectRequest); 

	    result = "https://" + S3_ENDPOINT + "/" + BUCKET + "/" + folderName;

	    return result;
        
	}
	
}