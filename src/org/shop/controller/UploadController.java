package org.shop.controller;

import org.apache.commons.io.FilenameUtils;
import org.shop.utils.Image;
import org.shop.utils.JSONImage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

/**
 * 上传图片工具类
 */
@Controller
public class UploadController {
    @RequestMapping("upload.do")
    @ResponseBody
    public JSONImage upload(@RequestParam("file") MultipartFile file) throws IOException {
        String fileName = UUID.randomUUID().toString().replaceAll("-", "_");
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        String storePath = "E:\\Eclipse_javaee_workspace\\shop\\web\\products\\" + fileName + "." + ext;
        JSONImage img = new JSONImage();
        file.transferTo(new File(storePath));
        img.setCode("0");
        img.setMsg("");
        Image image = new Image();
        image.setSrc("products/" + fileName + "." + ext);
        ArrayList<Image> list = new ArrayList<>();
        list.add(image);
        img.setData(list);
        return img;
    }
}
