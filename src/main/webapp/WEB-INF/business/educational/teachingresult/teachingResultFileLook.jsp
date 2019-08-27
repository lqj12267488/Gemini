<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/29
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
        .trlookFiles{
            border: 2px solid #00B83F;
        }
        .trlookFiles td{
            border: 2px solid #ffffff;
        }
        .imagediv{
            margin-top: 60%;
        }
    </style>
    <link href="../../../libs/css/webuploader/overallfiles.css" rel="stylesheet" type="text/css">
</head>

<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <%--<input id="publicityDeliveryId" hidden value="${publicityDelivery.id}">--%>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div id="container">
                    <table id="tableLookFiles" class="FilesTable">
                        <tr class="trlookFiles">
                            <td>文件名称</td>
                            <td>文件类型</td>
                            <td>&nbsp;操&nbsp;&nbsp;作&nbsp;</td>
                        </tr>
                        <c:forEach items="${uploadFiles}" varStatus="status" var="r">
                            <tr class="trlookFiles">
                                <td style="display: none;">${uploadFiles[status.count-1].fileId}</td>
                                <td>${uploadFiles[status.count-1].fileName}</td>
                                <td>${uploadFiles[status.count-1].fileType}</td>
                                <td>
                                    <a id="delFiles"><%--删除  --%></a>
                                    <a id="downloadFiles" class="downloadFiles"
                                       href="/files/downloadFiles?f_id=${uploadFiles[status.count-1].fileId}&f_name=${uploadFiles[status.count-1].fileName}&f_type=.${uploadFiles[status.count-1].fileType}"> 下载
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:forEach items="${uploadFiles}" varStatus="status" var="r2">
                        <div class="border2">
                            <img class="file_img" src="../../../${uploadFiles[status.count-1].fileUrl}${uploadFiles[status.count-1].fileId}.${uploadFiles[status.count-1].fileType}">
                            <p class="test3">${uploadFiles[status.count-1].fileName}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    /*
     function downFilesBtn(e) {
     var f_id = $(e).parent().parent().children("td").eq(0).text();
     var f_name = $(e).parent().parent().children("td").eq(1).text();
     var f_type = $(e).parent().parent().children("td").eq(2).text();
     $.ajax({
     type:"GET",
     url:"/files/downloadFiles",
     data:{
     f_id: f_id,
     f_name: f_name,
     f_type: f_type
     },
     error: function(request) {
     alert("下载连接失败");
     },
     success:function (data) {
     return data;
     }
     });
     }
     */

</script>
