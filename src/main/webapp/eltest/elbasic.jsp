<%@page import="java.util.LinkedList"%>
<%@page import="hello.DataBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- EL Expression Syntax ${} --%>

<!-- 문자열 출력 -->
${"Hello "}${"EL ~!"}<br />

<%
	// _jspService 메소드의 지역변수
	String hello = "Hello Hello";

	// JSP에서 스크립트릿을 사용해서 pageContest 영역객체에 hello라는 속성변수 명으로 "Hello Hello Hello" 속성값을 저장
	pageContext.setAttribute("hello", "Hello Hello Hello");
%>

<!-- 기본적으로 EL에서 변수는 pageScope부터 찾기 때문에 아래는 pageScope.hello와 같다 -->
${hello}<br />
<%-- ${pageContext.hello}<br /> --%>
${pageScope.hello}<br />
${hello==pageScope.hello}<br />

<!-- 아래의 anyVariable이라는 변수는 pageScope.anyVariable와 같다 값은 null이므로 아무것도 뜨지 않는다 -->
<!-- 변수가 없어도 (혹은 null)이라도 EL에서는 굳이 익셉션이나 에러를 발생시키지 않는다 -->
${anyVariable}

<%
	// request 속성변수 생성
	hello.HelloBean helloBean = new hello.HelloBean();
	helloBean.setStr("Hello~!");
	request.setAttribute("var1", helloBean);
%>

<!-- requestScope에서 속성변수 var1의 값을 출력 -->
${requestScope.var1}<br />

<!-- var1객체의 str프로퍼티의 값을 출력하려면 var1 객체에 public getter 메소드가 있어야 한다 -->
<%-- ${requestScope.var1.str}<br /> --%>

<!-- EL에서는 str을 입력하면 getter메소드를 사용한걸로 간주함  -->
${requestScope.var1.str}<br />

<!-- 
EL의 데이터 타입	
-->
<br />
${false}
<br />
${10}
<br />
${3.3}
<br />
${'hello'}${"hello"}
<br />
${null}

<!-- 
EL의 기본객체
-->
 <br /><br />
<!--  pageContext객체를 통해 다른 기본객체들을 얻어올 수 있다. ex) request, session, servletContext.. -->
${pageContext.request}<br />

<!-- 각 영역에 대한 영역객체 (각 영역의 속성변수들을 설정하거나 가져온다) -->
${pageScope}<br />
${requestScope}<br />
${sessionScope}<br />
${applicationScope}<br />

<!-- request parameter들에 대한 객체 -->
<!-- request.getParameter(파라미터변수명) -->
${param}<br />
<!-- request 파라미터들의 값들만 가져옴 -->
${paramValues}<br />

<!-- request header들에 대한 객체 -->
${header}<br />
${headerValues}<br />

<!-- cookie 객체 -->
${cookie}<br />

<!-- application(servletContext)의 초기화 파라미터 -->
${initParam.name}<br />
 
<!-- 
객체 접근
 -->	
 <%
 	DataBean dataBean = new DataBean();
 	Map<String, Object> map = new HashMap<String, Object>();
 	dataBean.setMap(map);
 	map.put("map1","map1Value");
 	map.put("map2","map2Value");
 	map.put("map3",null);
 	
 	List<String> list = new ArrayList<String>();
 	dataBean.setList(list);
 	list.add("list1");
 	list.add("list2");
 	list.add(null);

 	String[] strArray = {"hello ","EL"," world",null};
 	dataBean.setStrArray(strArray);
 	
 	pageContext.setAttribute("dataBean", dataBean);

 %>
 ${dataBean.map.map1}<br />
 ${dataBean.list[0]}<br />
 ${dataBean.strArray[0]}<br />
 
<!--  Map이나 List 객체 또는 배열의 Entry(구성요소)가 null일때 -->
 ${dataBean.map.map3}<br /> <!-- map은 데이터를 레퍼런스에 추가 -->
 ${dataBean.list[2]}<br />	<!-- list는 데이터를 배열에 추가 -->
 ${dataBean.strArray[3]}<br /><br />
 

<!-- Map이나 List 객체 또는 배열이 null일때 -->
<!--  EL에서는 null에 대한 처리를 내부적으로 수행하지만 화면에는 아무것도 출력하지 않도록 설계되어 있다 -->
<%
	Map<String,Object> map2 = null;
	List<String> list2 = null;
	String[] strArray2 = null;

	pageContext.setAttribute("map2", map2);
	pageContext.setAttribute("list2", list2);
	pageContext.setAttribute("strArray2", strArray2);
%>
map2 : ${map2}<br />
list2 : ${list2}<br />
strArray2 : ${strArray2}<br /><br />

<%
	pageContext.setAttribute("nullValue", null);
	pageContext.setAttribute("longValue", new Long(100));
	pageContext.setAttribute("floatValue", new Float(3.3));
%>

<!--  1. +, -, * -->
${100+nullValue}<br />
${nullValue+100}<br />
${3.3+nullValue}<br />
${nullValue+3.3}<br />
<br /><br />
${longValue+nullValue}<br />
${nullValue+longValue}<br />
${floatValue+nullValue}<br />
${nullValue+floatValue}<br />

<!-- 2, /, %, -(단항) -->
<br /><br />
<%-- ${100/nullValue}<br /> --%>
159 : ${nullValue/100}<br />
<%-- ${3.3/nullValue}<br /> --%>
161 : ${nullValue/3.3}<br />
<br /><br />
<%-- ${longValue/nullValue}<br /> --%>
164 : ${nullValue/longValue}<br />
<%-- ${floatValue/nullValue}<br /> --%>
166 : ${nullValue/floatValue}<br />

<br /><br />
<%-- ${100%nullValue}<br /> --%>
170 : ${nullValue%100}<br />
<%-- ${3.3%nullValue}<br /> --%>
172 : ${nullValue%3.3}<br />
<br /><br />
<%-- ${longValue%nullValue}<br /> --%>
175 : ${nullValue%longValue}<br />
<%-- ${floatValue%nullValue}<br /> --%>
177 : ${nullValue%floatValue}<br />
<br /><br />
${-nullValue }<br />
${-longValue }<br />
${-floatValue }<br />
${-0 }<br />
${-100}<br />
${-3.3}<br />

<!-- 비교연산자 -->
<%
	pageContext.setAttribute("value1", 20);
	pageContext.setAttribute("value2", 30);
%>
${value1 > value2} or ${value1 gt value2}<br />
${value1 > value2} or ${value1 lt value2}<br />
${value1 >= value2} or ${value1 ge value2}<br />
${value1 >= value2} or ${value1 le value2}<br />
${value1 == value2} or ${value1 eq value2}<br />
${value1 != value2} or ${value1 ne value2}<br />

<!-- 논리연산자 -->
${true && false} or ${true and false} <br />
${true || false} or ${true or false} <br />
${!true} or ${not true} <br />

<!-- empty 연산자 -->
<%
	Object obj11 = new Object();
	Object obj22 = null;
	Map<String, Object>map11 = new HashMap<String,Object>();
	Map<String, Object>map22 = null;
	Map<String, Object>map33 = new HashMap<String,Object>();
	map33.put("entryKey","entryValue");
	
	List<String>list11 = new LinkedList<String>();
	List<String>list22 = null;
	List<String>list33 = new LinkedList<String>();
	list33.add("item");
	
	String[] strArray11 = null;
	String[] strArray22 = new String[10];
	String[] strArray33 = new String[10];
	strArray33[0] = "item";
	
	pageContext.setAttribute("obj11", obj11);
	pageContext.setAttribute("obj22", obj22);
	pageContext.setAttribute("map11", map11);
	pageContext.setAttribute("map22", map22);
	pageContext.setAttribute("map33", map33);
	pageContext.setAttribute("list11", list11);
	pageContext.setAttribute("list22", list22);
	pageContext.setAttribute("list33", list33);
	pageContext.setAttribute("strArray11", strArray11);
	pageContext.setAttribute("strArray22", strArray22);
	pageContext.setAttribute("strArray33", strArray33);
	
%>

<!-- null이거나 원소를 넣어주지 않으면 비어있어서 true를 리턴한다 -->
<br /><br />
${empty obj11} <br />
obj22 : ${empty obj22} <br />
map11 : ${empty map11} <br />
map22 : ${empty map22} <br />
${empty map33} <br />
list11 : ${empty list11} <br />
list22 : ${empty list22} <br />
${empty list33} <br />
strArray11 : ${empty strArray11} <br />
${empty strArray22} <br />
${empty strArray33} <br />

<!-- 
3항 연산자
 -->
${3==3? "3은 3입니다" : "3은 3이 아닙니다"}<br />
${empty map33? "map33은 엔트리가 없습니다." : "map33은 엔트리가 있습니다" }<br />
${!empty map33? "map33은 엔트리가 없습니다." : "map33은 엔트리가 있습니다" }<br />

<!-- 문자열 연결 --> 
\${"hello"+"world"}<br />
${"hello"+=" world"}<br />















