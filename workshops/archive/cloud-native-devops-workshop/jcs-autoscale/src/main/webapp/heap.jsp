<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>Load app - Heap</title>
</head>

<body>

<form method="post">
    <%
        int totalHeapInUse = 0;
        if (request.getParameter("totalHeapInUse") != null) {
            totalHeapInUse = Integer.parseInt(request.getParameter("totalHeapInUse"));
        }

        if (request.getParameter("allocateHeap") != null) {
            int allocateHeap =  Integer.parseInt(request.getParameter("allocateHeap"));
            LinkedList<byte[]> byteArrayLinkedList = null;
            if (session.getAttribute("ByteArrayLinkedList") != null) {
                byteArrayLinkedList = (LinkedList<byte[]>) session.getAttribute("ByteArrayLinkedList");
            }
            else {
                byteArrayLinkedList = new LinkedList<byte[]>();
            }
            if(allocateHeap > 0){
                for(int i = 0; i < allocateHeap * 10; i++){
                    byteArrayLinkedList.add(new byte[100 * 1024]);
try {
              Thread.sleep(1);
            }catch (Exception ex){
              //ignore;
            }
                }
              totalHeapInUse+=allocateHeap;
            } else {
                for(int i = allocateHeap * 10; i < 0; i++){
                    byteArrayLinkedList.remove(0);
try {
              Thread.sleep(1);
            }catch (Exception ex){
              //ignore;
            }
                }
    totalHeapInUse+=allocateHeap;
            }
            session.setAttribute("ByteArrayLinkedList", byteArrayLinkedList);
        }
    %>

    <table border="0">
        <tr>
            <td height="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <font face="Arial, Helvetica, sans-serif;" size="4px">
                    Total Heap in Use = <%= totalHeapInUse %> MB
                </font>
            </td>
        </tr>
        <tr>
            <td height="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                Allocate Heap : <input type="text" name="allocateHeap" style="height:50px; width:150px;"/> MB
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="submit" value="Submit" style="height:50px; width:150px"/>
            </td>
        </tr>
        <tr>
            <td height="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden" name="totalHeapInUse" value="<%= totalHeapInUse %>">
            </td>
        </tr>

    </table>
</form>

</body>
</html>
