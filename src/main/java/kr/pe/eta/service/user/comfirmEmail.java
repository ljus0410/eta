package kr.pe.eta.service.user;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import jakarta.activation.DataHandler;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.util.ByteArrayDataSource;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class comfirmEmail {

	@Autowired
	private JavaMailSender javaMailSender;

	@Value("${mail.username}")
	private String id;

	// 인증번호 생성
	private final String ePw = createKey();

	private final MimeBodyPart resizedImagePart;

	public comfirmEmail() throws IOException, MessagingException {
		this.resizedImagePart = resizeImageAndAttach("src/main/resources/static/templates/images/pictures/taxi11.png",
				300, 200);
	}

	public MimeMessage createMessage(String email) throws MessagingException, IOException {
		MimeMessage message = javaMailSender.createMimeMessage();

		message.addRecipients(MimeMessage.RecipientType.TO, email);
		message.setSubject("eTa 이메일 인증");

		String msg = "";
		msg += "<h1 style='font-size: 30px; color:gold; padding-right: 30px; padding-left: 100px;'>eTa</h1>";
		msg += "<p style='font-size: 17px; padding-right: 30px; padding-left: 30px;'>eTa만의 매력을 느껴보세요</p>";
		msg += "<img src='cid:logo'>"; // 이미지 첨부 방법 수정
		msg += "<p style='margin-top: 15px; font-size: 17px; padding-right: 30px; padding-left: 30px;'>아래 확인 코드를 입력해주세요.</p>";
		msg += "<div style='padding-right: 30px; padding-left: 100px; margin: 22px 0 20px;'><table style='border-collapse: collapse; border: 0;height: 0px; table-layout: fixed; word-wrap: break-word; border-radius: 6px;'><tbody><tr><td style='text-align: center; vertical-align: middle; font-size: 17px;'>";
		msg += "<strong>" + ePw + "</strong>";
		msg += "</td></tr></tbody></table></div>";
		// 이미지를 메시지에 추가
		MimeMultipart multipart = new MimeMultipart();
		multipart.addBodyPart(resizedImagePart);

		MimeBodyPart htmlPart = new MimeBodyPart();
		htmlPart.setContent(msg, "text/html; charset=utf-8");

		multipart.addBodyPart(htmlPart);

		message.setContent(multipart);
		message.setFrom(new InternetAddress(id, "eTa"));

		return message;
	}

	// 이미지 크기 조절 메서드
	private MimeBodyPart resizeImageAndAttach(String imagePath, int targetWidth, int targetHeight)
			throws IOException, MessagingException {
		BufferedImage originalImage = ImageIO.read(new File(imagePath));
		BufferedImage resizedImage = resizeImage(originalImage, targetWidth, targetHeight);

		// MimeBodyPart 생성
		MimeBodyPart imagePart = new MimeBodyPart();
		imagePart.setDataHandler(new DataHandler(new ByteArrayDataSource(convertToBytes(resizedImage), "image/png")));
		imagePart.setContentID("<logo>");
		imagePart.setDisposition(MimeBodyPart.INLINE);

		return imagePart;
	}

	private BufferedImage resizeImage(BufferedImage originalImage, int targetWidth, int targetHeight) {
		BufferedImage resizedImage = new BufferedImage(targetWidth, targetHeight, BufferedImage.TYPE_INT_ARGB);
		Graphics2D graphics = resizedImage.createGraphics();
		graphics.drawImage(originalImage, 0, 0, targetWidth, targetHeight, null);
		graphics.dispose();
		return resizedImage;
	}

	private byte[] convertToBytes(BufferedImage image) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(image, "png", baos);
		return baos.toByteArray();
	}

	public static String createKey() {
		StringBuilder key = new StringBuilder();
		Random rnd = new Random();

		for (int i = 0; i < 6; i++) { // 인증코드 6자리
			key.append(rnd.nextInt(10));
		}
		return key.toString();
	}

	/*
	 * 메일 발송 sendSimpleMessage의 매개변수로 들어온 to는 인증번호를 받을 메일주소 MimeMessage 객체 안에 내가 전송할
	 * 메일의 내용을 담아준다. bean으로 등록해둔 javaMailSender 객체를 사용하여 이메일 send
	 */
	public String sendSimpleMessage(String email) throws Exception {
		MimeMessage message = createMessage(email);
		try {
			javaMailSender.send(message); // 메일 발송
		} catch (MailException es) {
			es.printStackTrace();
			throw new IllegalArgumentException();
		}
		return ePw; // 메일로 보냈던 인증 코드를 서버로 리턴
	}
}
