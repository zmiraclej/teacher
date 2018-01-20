package cn.com.wtrj.edu.community.util;

import java.awt.BasicStroke;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Shape;
import java.awt.geom.AffineTransform;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.OutputStream;
import java.util.Hashtable;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.Result;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;


/**
 * 二维码工具类
 * @author Administrator
 *
 */
public class QRCodeUtil {
  private static final String CHARSET = "utf-8";
  private static final String FORMAT_NAME = "JPG";
  // 二维码尺寸
  private static final int QRCODE_SIZE = 300;
  // LOGO宽度
  private static final int WIDTH = 60;
  // LOGO高度
  private static final int HEIGHT = 60;
  
  // 长度+地址+子系统权限
  public static final String PRE_CODE = "2F01FF";
  //去除卡号以外的编码
  public static final String SUF_CODE = "00000000000000000000000000000000000000000000000000000000000000000002468ACE13579BDF";

  
  private static BufferedImage createImage(String content, String imgPath, boolean needCompress) throws Exception {
    Hashtable<EncodeHintType, Object> hints = new Hashtable<EncodeHintType, Object>();
    hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
    hints.put(EncodeHintType.CHARACTER_SET, CHARSET);
    hints.put(EncodeHintType.MARGIN, 1);
    BitMatrix bitMatrix =
        new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, QRCODE_SIZE, QRCODE_SIZE, hints);
    int width = bitMatrix.getWidth();
    int height = bitMatrix.getHeight();
    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        image.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF000000 : 0xFFFFFFFF);
      }
    }
    if (imgPath == null || "".equals(imgPath)) {
      return image;
    }
    // 插入图片
    QRCodeUtil.insertImage(image, imgPath, needCompress);
    return image;
  }


  private static void insertImage(BufferedImage source, String imgPath, boolean needCompress) throws Exception {
    File file = new File(imgPath);
    if (!file.exists()) {
      return;
    }
    Image src = ImageIO.read(new File(imgPath));
    int width = src.getWidth(null);
    int height = src.getHeight(null);
    if (needCompress) { // 压缩LOGO
      if (width > WIDTH) {
        width = WIDTH;
      }
      if (height > HEIGHT) {
        height = HEIGHT;
      }
      Image image = src.getScaledInstance(width, height, Image.SCALE_SMOOTH);
      BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
      Graphics g = tag.getGraphics();
      g.drawImage(image, 0, 0, null); // 绘制缩小后的图
      g.dispose();
      src = image;
    }
    // 插入LOGO
    Graphics2D graph = source.createGraphics();
    int x = (QRCODE_SIZE - width) / 2;
    int y = (QRCODE_SIZE - height) / 2;
    graph.drawImage(src, x, y, width, height, null);
    Shape shape = new RoundRectangle2D.Float(x, y, width, width, 6, 6);
    graph.setStroke(new BasicStroke(3f));
    graph.draw(shape);
    graph.dispose();
  }

  //二维码生成
  public static void encode(String content, String imgPath, String destPath, boolean needCompress) throws Exception {
    BufferedImage image = QRCodeUtil.createImage(content, imgPath, needCompress);
    File descFile = new File(destPath);
    if (!descFile.exists()) {
      descFile.mkdirs();
    }
    ImageIO.write(image, FORMAT_NAME, new File(destPath));
  }


  public static void encode(String content, String imgPath, String destPath) throws Exception {
    QRCodeUtil.encode(content, imgPath, destPath, true);
  }


  public static void encode(String content, String destPath, boolean needCompress) throws Exception {
    QRCodeUtil.encode(content, null, destPath, needCompress);
  }


  public static void encode(String content, String destPath) throws Exception {
    QRCodeUtil.encode(content, null, destPath, false);
  }


  public static void encode(String content, String imgPath, OutputStream output, boolean needCompress)
      throws Exception {
    BufferedImage image = QRCodeUtil.createImage(content, imgPath, needCompress);
    ImageIO.write(image, FORMAT_NAME, output);
  }


  public static void encode(String content, OutputStream output) throws Exception {
    QRCodeUtil.encode(content, null, output, false);
  }

  //二维码解析
  public static String decode(File file) throws Exception {
    BufferedImage image;
    image = ImageIO.read(file);
    if (image == null) {
      return null;
    }
    BufferedImageLuminanceSource source = new BufferedImageLuminanceSource(image);
    BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
    Result result;
    Hashtable<DecodeHintType, Object> hints = new Hashtable<DecodeHintType, Object>();
    hints.put(DecodeHintType.CHARACTER_SET, CHARSET);
    result = new MultiFormatReader().decode(bitmap, hints);
    String resultStr = result.getText();
    return resultStr;
  }


  public static String decode(String path) throws Exception {
    return QRCodeUtil.decode(new File(path));
  }

/*  public static void main(String[] args) throws Exception {
	String head = "2F01FF";
    String text = "DB2966FF00000000000000000000000000000000000000000000000000000000000000000002468ACE13579BDF";
    
    System.out.println(text.substring(0,text.length()-16));
    
    String qtext = head + text.substring(0,text.length()-16) +MD5Util.MD5(text, true, true);
    
    QRCodeUtil.encode(qtext, "", "E:\\qcode\\b.jpg", true);
    
    System.out.println(QRCodeUtil.decode("E:\\qcode\\b.jpg"));
    
  }*/
  
  static class BufferedImageLuminanceSource extends LuminanceSource {
    private final BufferedImage image;
    private final int left;
    private final int top;

    public BufferedImageLuminanceSource(BufferedImage image) {
      this(image, 0, 0, image.getWidth(), image.getHeight());
    }

    public BufferedImageLuminanceSource(BufferedImage image, int left, int top, int width, int height) {
      super(width, height);

      int sourceWidth = image.getWidth();
      int sourceHeight = image.getHeight();
      if (left + width > sourceWidth || top + height > sourceHeight) {
        throw new IllegalArgumentException("Crop rectangle does not fit within image data.");
      }

      for (int y = top; y < top + height; y++) {
        for (int x = left; x < left + width; x++) {
          if ((image.getRGB(x, y) & 0xFF000000) == 0) {
            image.setRGB(x, y, 0xFFFFFFFF); // = white
          }
        }
      }

      this.image = new BufferedImage(sourceWidth, sourceHeight, BufferedImage.TYPE_BYTE_GRAY);
      this.image.getGraphics().drawImage(image, 0, 0, null);
      this.left = left;
      this.top = top;
    }


    public byte[] getRow(int y, byte[] row) {
      if (y < 0 || y >= getHeight()) {
        throw new IllegalArgumentException("Requested row is outside the image: " + y);
      }
      int width = getWidth();
      if (row == null || row.length < width) {
        row = new byte[width];
      }
      image.getRaster().getDataElements(left, top + y, width, 1, row);
      return row;
    }


    public byte[] getMatrix() {
      int width = getWidth();
      int height = getHeight();
      int area = width * height;
      byte[] matrix = new byte[area];
      image.getRaster().getDataElements(left, top, width, height, matrix);
      return matrix;
    }


    public boolean isCropSupported() {
      return true;
    }


    public LuminanceSource crop(int left, int top, int width, int height) {
      return new BufferedImageLuminanceSource(image, this.left + left, this.top + top, width, height);
    }


    public boolean isRotateSupported() {
      return true;
    }


    public LuminanceSource rotateCounterClockwise() {
      int sourceWidth = image.getWidth();
      int sourceHeight = image.getHeight();
      AffineTransform transform = new AffineTransform(0.0, -1.0, 1.0, 0.0, 0.0, sourceWidth);
      BufferedImage rotatedImage = new BufferedImage(sourceHeight, sourceWidth, BufferedImage.TYPE_BYTE_GRAY);
      Graphics2D g = rotatedImage.createGraphics();
      g.drawImage(image, transform, null);
      g.dispose();
      int width = getWidth();
      return new BufferedImageLuminanceSource(rotatedImage, top, sourceWidth - (left + width), getHeight(), width);
    }
  }
}
