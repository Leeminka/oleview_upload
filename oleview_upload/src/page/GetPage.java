package page;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * Servlet implementation class GetPage
 */
@WebServlet("/GetPage")
public class GetPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String url = request.getParameter("url");
		String dom_data = request.getParameter("dom_data");
		URLDecoder.decode(url.replace("+", "%2B"), "UTF-8").replace("%2B", "+");
		URLDecoder.decode(dom_data.replace("+", "%2B"), "UTF-8").replace("%2B",
				"+");

		String res = "�߸��� URL �Դϴ�.";
		int fromIndex = -1;
		int counter = 0;

		// Dom data parse
		String[] dom_arry = dom_data.split(",");
		String dom_string = "";

		// �������� BODY �� HTML �� ����
		for (int i = 3; i < dom_arry.length; i++) {
			dom_string += dom_arry[i] + " ";
		}

		// http ���������� �Է� ������ ��쿡 �Է�����
		if (url.toLowerCase().indexOf("http://") == -1) {
			url = "http://" + url;
		}

		// ROOT �ּҸ� �������� ���ؼ�
		String root_url = url;
		while ((fromIndex = url.toLowerCase().indexOf('/', fromIndex + 1)) > 0
				&& url.length() > fromIndex) {
			if (counter >= 2) {
				root_url = url.substring(0, fromIndex);
				break;
			}
			counter++;
		}

		try {
			Document doc = Jsoup.connect(url).get();
			Element head = doc.head();
			Element body = doc.body();
			Elements head_els = head.getAllElements();
			Elements body_els = body.getAllElements();

			for (Iterator<Element> Iter = head_els.iterator(); Iter.hasNext();) {
				Element e = Iter.next();
				String tagName = e.tagName().toLowerCase();
				if (tagName.equals("link")) {
					String href_url = e.attr("href");
					if (href_url.toLowerCase().indexOf("http") == -1) {
						href_url = root_url + href_url;
						e.attr("href", href_url);
					}
				} else if (tagName.equals("img")) {
					String src_url = e.attr("src");
					if (src_url.toLowerCase().indexOf("http") == -1) {
						src_url = root_url + src_url;
						e.attr("src", src_url);
					}
				} else if (tagName.equals("script")) {
					String src_url = e.attr("src");
					if (!src_url.equals("")) {
						if (src_url.toLowerCase().indexOf("http") == -1) {
							src_url = root_url + src_url;
							e.attr("src", src_url);
						}
					}
					// e.remove();
				} else if (tagName.equals("iframe")) {
					// e.remove();
				}
			}
			System.out.println(dom_string);
			Elements selected_body = doc.select(dom_string).clone();

			Elements script_els = new Elements();
			// ��ũ��Ʈ�� ��ũ���� script_els�� ����
			for (Iterator<Element> Iter = body_els.iterator(); Iter.hasNext();) {
				Element e = Iter.next();
				String tagName = e.tagName().toLowerCase();
				if (tagName.equals("script")) {
					String src_url = e.attr("src");
					if (!src_url.equals("")) {
						if (src_url.toLowerCase().indexOf("http") == -1) {
							src_url = root_url + src_url;
							e.attr("src", src_url);
						}
					}
					script_els.add(e);
				} else if (tagName.equals("link")) {
					String href_url = e.attr("href");
					if (href_url.toLowerCase().indexOf("http") == -1) {
						href_url = root_url + href_url;
						e.attr("href", href_url);
					}
					script_els.add(e);
				}

				if (tagName != "body")
					e.remove();
			}

			// ������ �κ� �߰� + ��ũ��Ʈ �� �߰�
			body.append(selected_body.toString());
			body.append(script_els.toString());

			res = doc.html();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(res);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}