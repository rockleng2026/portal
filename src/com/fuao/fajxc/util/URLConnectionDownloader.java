package com.fuao.fajxc.util;

import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;

import javax.imageio.ImageIO;

public class URLConnectionDownloader {
	/**
	 * 下载文件到本地
	 * 
	 * @param urlString
	 *            被下载的文件地址
	 * @param filename
	 *            本地文件名
	 * @throws Exception
	 *             各种异常
	 */
	public static void download(String urlString ,String filename)
			throws Exception {
		// 判断文件是否存在
		File file = new File(filename);
		if (!file.exists()) {
			// 构造URL
			URL url = new URL(urlString);
			// 打开连接
			URLConnection con = url.openConnection();
			// 输入流
			InputStream is = con.getInputStream();
			// 1K的数据缓冲
			byte[] bs = new byte[1024];
			// 读取到的数据长度
			int len;
			// 输出的文件流
			OutputStream os = new FileOutputStream(filename);
			// 开始读取
			while ((len = is.read(bs)) != -1) {
				os.write(bs, 0, len);
			}
			// 完毕，关闭所有链接
			os.close();
			is.close();
		}
	}

	/**
	 * 生成图片缩略图
	 * @param imagepath 原图片地址
	 * @param newpath 新图片地址
	 * @param maxWidth 图片的最大宽度
	 * @param maxHeight 图片的最大高度
	 * @return 
	 */
	public static boolean scale(String imagepath, String newpath,int maxWidth,int maxHeight) {
		// 返回一个 BufferedImage，作为使用从当前已注册 ImageReader 中自动选择的 ImageReader 解码所提供
		// File 的结果
		System.out.println("image form:"+imagepath+"\t to:"+newpath);
		BufferedImage image = null;
		try {
			image = ImageIO.read(new File(imagepath));
		} catch (IOException e) {
			System.err.println("读取图片文件出错！" + e.getMessage());
			return false;
		}
		double Ratio = 0.0;
		double width = maxWidth*1.0/image.getWidth();//得到宽度最大值的比例数
		double height = maxHeight*1.0/image.getHeight();//得到高度最大值的比例数
		// 图片要缩放的比例
		if(width>=height){
			Ratio = height;
		}else{
			Ratio = width;
		}
		// 根据仿射转换和插值类型构造一个 AffineTransformOp
		AffineTransformOp op = new AffineTransformOp(AffineTransform
				.getScaleInstance(Ratio, Ratio), null);
		// 转换源 BufferedImage 并将结果存储在目标 BufferedImage 中。
		image = op.filter(image, null);
		
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(new File(newpath));
			ImageIO.write((BufferedImage) image, "jpg", out);
			out.close();
		} catch (Exception e) {
			System.err.println("写图片文件出错!!" + e.getMessage());
			return false;
		}
		return true;
	}

	public static void main(String[] args) throws Exception {
//		String url = "http://images.movie.xunlei.com/gallery/511/5cb80d2f09cfd193b6308320166b051d.jpg";
//		String subfix = url.substring(url.lastIndexOf("."));
//		String filename = System.currentTimeMillis() + subfix;
//		String position = "D:/";
//		download("http://s.zbjimg.com/img/tlbg.gif","D:/tlbg.gif" );
//		System.out.println(position+filename);
		System.out.println(TimePattern.doTimeDf3(new Date()));
		scale("D:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\FAJxc\\product_pic\\2013061918023331417.jpg","D:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\FAJxc\\product_pic\\ce.jpg",310,310);
		System.out.println(TimePattern.doTimeDf3(new Date()));
	}
}
