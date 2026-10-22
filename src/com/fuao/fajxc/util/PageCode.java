package com.fuao.fajxc.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PageCode extends HttpServlet {

	private final static int HEIGHT = 20;
	private final static int WIDTH = 70;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("image/jpeg");
		ServletOutputStream sos = response.getOutputStream();

		// 设置浏览器不要缓存此图片
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);

		// 创建内存图象并获得其图形上下�?
		BufferedImage image = new BufferedImage(WIDTH, HEIGHT,BufferedImage.TYPE_INT_RGB);
		Graphics g = image.getGraphics();
		// 产生随机的认证码
		char[] rands = generateCheckCode();
		// 产生图像
		drawBackground(g);
		drawRands(g, rands);

		// 结束图像的绘制过程，完成图像
		g.dispose();

		// 将当前验证码存入到Session�?
		session.setAttribute("pageValidateCode", new String(rands));

		// 将图像输出到客户�?
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		ImageIO.write(image, "JPEG", bos);
		byte[] buf = bos.toByteArray();
		response.setContentLength(buf.length);
		// 下面的语句也可写成：bos.writeTo(sos);
		sos.write(buf);
		bos.close();
		sos.close();

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private char[] generateCheckCode() {
		// 定义验证码的字符�?
		String chars = "23456789aAbBcCdDeEfFgGhHjJkKLmMnNpPqQrRsStTuUvVwWxXyYzZ";
		char[] rands = new char[4];
		Random rad = new Random(System.currentTimeMillis());
		for (int i = 0; i < 4; i++) {
			rands[i] = chars.charAt(rad.nextInt(55));
		}
		return rands;
	}

	private void drawRands(Graphics g, char[] rands) {
		g.setColor(new Color(1,28,108));
		g.setFont(new Font("", Font.PLAIN, 18));
		// 在不同的高度上输出验证码的每个字�?
		for (int i = 0; i < rands.length; i++) {
			g.drawString("" + rands[i], 2+i * 16, 16);
		}
	}

	private void drawBackground(Graphics g) {
		// 画背�?
		g.setColor(new Color(0xdcdcdc));
		g.fillRect(0, 0, WIDTH, HEIGHT);
		Random rad = new Random(System.currentTimeMillis());
		// 随机产生30个干扰点
		for (int i = 0; i < 50; i++) {
			int x = rad.nextInt(WIDTH);
			int y = rad.nextInt(HEIGHT);
			int red = rad.nextInt(255);
			int green = rad.nextInt(255);
			int blue = rad.nextInt(255);
			g.setColor(new Color(red, green, blue));
			g.drawOval(x, y, 1, 0);
		}
	}
}
