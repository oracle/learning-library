<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!private class LoadRunner implements Runnable {

    String sLoadFactor;
    long lTimeToRunInMillisec;

    public LoadRunner(long time, String factor) {
      lTimeToRunInMillisec = time;
      sLoadFactor = factor;
    }

    public void run() {

      long lListSize = 100000;
      long lStartTime = System.currentTimeMillis();

      if (sLoadFactor.equals("low")) {
        lListSize = 10000;
      } else if (sLoadFactor.equals("mid")) {
        lListSize = 100000;
      } else if (sLoadFactor.equals("high")) {
        lListSize = 1000000;
      }

      System.out.println("Load Time ====================== " + lTimeToRunInMillisec);
      System.out.println("Load Factor ==================== " + sLoadFactor);
      

      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      Calendar calendar = Calendar.getInstance();

      System.out.println(sdf.format(calendar.getTime()) + " - " + Thread.currentThread().getName()
          + " started. Time to run: " + lTimeToRunInMillisec + " ms");
      ArrayList<String> list = new ArrayList<String>();

      for (long i = 0; i < lListSize; i++) {
        list.add(UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString());
      }

      do {
        Collections.shuffle(list);
        Collections.sort(list);
        if (System.currentTimeMillis() - lStartTime > lTimeToRunInMillisec) {
          break;
        }
        long lLeftTime = lTimeToRunInMillisec - (System.currentTimeMillis() - lStartTime);
        calendar.setTimeInMillis(System.currentTimeMillis());
        System.out.println(sdf.format(calendar.getTime()) + " - " + Thread.currentThread().getName()
            + " running. Time to run: " + lLeftTime + " ms");
      } while (true);

      System.out.println("CPULoadRunnable completed.");

    }

  }%>


<html>
<head>
<title>Load app - CPU</title>
</head>

<body>
  <form method="post">
    <%
      int iThreadNum = 5;
      long lTimeToRunInMillisec =  100000;
      String sLoadFactor = "mid";
      if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("submit") != null) {

        if (request.getParameter("runCPULoadTime") != null) {
          lTimeToRunInMillisec = Long.parseLong(request.getParameter("runCPULoadTime"));
        }

        if (request.getParameter("loadfactor") != null) {
          sLoadFactor = request.getParameter("loadfactor");
        }
        
        LoadRunner load = new LoadRunner(lTimeToRunInMillisec, sLoadFactor);
        for (int i = 0; i < iThreadNum; i++) {
          Thread thread = new Thread(null, load, "CPULOAD_" + i);
          thread.start();
          Thread.sleep(1000);
        }
      }
    %>

    <table border="0">
      <tr>
        <td height="3">&nbsp;</td>
      </tr>
      <tr>
        <td>Run <select id="loadfactor" name="loadfactor">
            <option value="low">Low</option>
            <option value="mid">Mid</option>
            <option value="high">High</option>
        </select> CPU load for : <input type="text" name="runCPULoadTime"
          style="width: 100px" /> ms &nbsp;&nbsp;&nbsp;&nbsp; <input
          type="submit" name="submit" value="Submit" />
        </td>
      </tr>
      <tr>
        <td height="3">&nbsp;</td>
      </tr>


    </table>
  </form>

</body>
</html>
