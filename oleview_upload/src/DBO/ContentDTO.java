package DBO;

//컨텐츠 객체 데이터
public class ContentDTO {
	private String title;
	private String user_id;
	private String categoryName;
	private String url;
	private String dom_data;
	private int width;
	private int height;
	private int left;
	private int top;

	public ContentDTO(String title, String user_id, String categoryName, String url, String dom_data, int width,
			int height, int left, int top) {
		// TODO Auto-generated constructor stub
		this.title = title;
		this.user_id = user_id;
		this.categoryName = categoryName;
		this.url = url;
		this.dom_data = dom_data;
		this.width = width;
		this.height = height;
		this.left = left;
		this.top = top;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDom_data() {
		return dom_data;
	}

	public void setDom_data(String dom_data) {
		this.dom_data = dom_data;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getLeft() {
		return left;
	}

	public void setLeft(int left) {
		this.left = left;
	}

	public int getTop() {
		return top;
	}

	public void setTop(int top) {
		this.top = top;
	}

	public String getCategoryName() {
		return this.categoryName;
	}
	public void setCategoryName(String categoryName){
		this.categoryName = categoryName;
	}
	
}
