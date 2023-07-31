package com.ssafy.moyeolam.infra.storage.service;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class S3Service {
    @Value("${cloud.aws.s3.bucket}")
    private String bucket;
    private final AmazonS3 amazonS3;

    public Map<String, String> uploadFile(MultipartFile multipartFile, String dirName) throws IOException {
        String originalFileName = dirName + "/" + multipartFile.getOriginalFilename();

        String ext = originalFileName.split("\\.")[1];
        String fileNameWithoutExt = originalFileName.split("\\.")[0];
        String fileName = fileNameWithoutExt + System.currentTimeMillis() + "." + ext;
        String contentType = "";

        switch (ext) {
            case "jpeg":
                contentType = "image/jpeg";
                break;
            case "png":
                contentType = "image/png";
                break;
            case "txt":
                contentType = "text/plain";
                break;
            case "csv":
                contentType = "text/csv";
                break;
        }

        try {
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType(contentType);

            amazonS3.putObject(new PutObjectRequest(bucket, fileName, multipartFile.getInputStream(), metadata)
                    .withCannedAcl(CannedAccessControlList.PublicRead));
        } catch (AmazonServiceException e) {
            e.printStackTrace();
        } catch (SdkClientException e) {
            e.printStackTrace();
        }

        ListObjectsV2Result listObjectsV2Result = amazonS3.listObjectsV2(bucket);
        List<S3ObjectSummary> objectSummaries = listObjectsV2Result.getObjectSummaries();

        for (S3ObjectSummary object: objectSummaries) {
            System.out.println("object = " + object.toString());
        }
        Map<String,String> result = new HashMap<>();
        result.put("url",amazonS3.getUrl(bucket, fileName).toString());
        result.put("fileName", fileName);
        return result;
    }

    public void deleteFile(String imagePath) {
        try {
            amazonS3.deleteObject(new DeleteObjectRequest(bucket, imagePath));
            // System.out.println("파일 " + imagePath + "가 S3 버킷 " + bucket + "에서 삭제되었습니다.");
        } catch (Exception e) {
            System.out.println("파일 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
}