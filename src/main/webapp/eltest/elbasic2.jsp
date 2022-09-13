<%@page import="functions.MyFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="/WEB-INF/tlds/myFunction.tld" prefix="myFunction" %>  

<!--  EL Collection -->
1. List : ${list=['a','b','c']} <br />
	List[1] : ${list[1]} <br />
2. Map : ${map={'name':'홍길동','age':'20'}} <br />
	map.name : ${map.name} <br />
	map.age : ${map.age} <br />
3. Set : ${set={1,2,3}}<br /> <!-- Set은 인덱스 접근 불가 -->
<br /><br />

<!-- Semicolon 연산자 -->
${1+1;2+2}<br />
${sum1=1+1; sum2 = sum1+2}<br />
${list=[1,2,3]}<br />
${list=[1,2,3];''}<br />

 ${myFunction:sum(100,200)}<br />
${MyFunction.sum(200,300)}
 











