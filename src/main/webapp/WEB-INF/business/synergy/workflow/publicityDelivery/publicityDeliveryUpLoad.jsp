<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/15
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
--%>

<%--<link href="../../../../../libs/css/swfupload/default.css" rel="stylesheet" type="text/css">
<link href="../../../../../libs/css/swfupload/button.css" rel="stylesheet" type="text/css">
<link href="../../../../../libs/css/ext-theme-classic/ext-theme-classic-all.css" rel="stylesheet" type="text/css">
<link href="../../../../../libs/css/extjs/ext-all.css" rel="stylesheet" type="text/css">--%>

<%--
其中handlers.js是上传中一系列的事件，可以在此文件中修改自己的上传所需要的事件。如开始上传、取消、停止上传等
swfupload.queue.js这个文件主要是完成将客户端选择的多一个文件一个个的排成一个队列，然后依次向服务器上传。
swfupload.swf是flash文件，就那个添加或上传的按钮
--%>
<%--<script type="text/javascript" src="../../../../../libs/js/plugins/swfupload/swfupload.js"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/swfupload/SwfUploadPanel.js"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/swfupload/handlers.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/swfupload/swfupload.swf"></script>

<script type="text/javascript" src="../../../../../libs/js/plugins/extjs/ext-all.js"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/extjs/ext-base.js"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/extjs/ext-lang-zh_CN.js"></script>--%>


<link href="../../../../../libs/css/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<link href="../../../../../libs/css/webuploader/uploadstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../../../../libs/js/plugins/webuploader/webuploader.js"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/webuploader/upload.js"></script>
<script type="text/javascript" src="../../../../../libs/js/plugins/avalon/avalon.js"></script>


<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
        .test4{
            float: left;
            margin-right: 1%;
        }
        .test3{
            font-size: 10px;
            text-align: center;
            margin-top: 3px;
        }
        .test2{
            border: 2px solid #8dc0f5;
            width: 100%;
            text-align: center;
        }
        .test2 td{
            border: 2px solid #00B83F;
            margin-right: 2%;
            padding-right: 2%;
        }
        .upload-state-done{
            color: #4cd964;
        }
        .test5{
            margin: 1px;
        }
        /*TODO BEGIN*/
        .border2{
            width: 110px;
            height: 110px;
            float: left;
            margin-top: 15px;
            margin-right: 8px;
        }
        .file_img{
            width: 100%;
            height:100%;
        }
        /*TODO END*/
    </style>
</head>
<div class="modal-dialog" style="width: 700px;margin-left: 0;">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">文件上传</span>
            <input id="publicityDeliveryId" hidden value="${publicityDelivery.id}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div id="wrapper">
                    <div id="container">
                        <!--头部，相册选择和格式选择-->
                        <div id="uploader">
                            <div>
                                 <div class="queueList">
                                    <div id="filePicker" class="_filePicker_"></div>
                                     <table id="tableFile" class="test2">
                                         <tr>
                                             <td>文件名称</td>
                                             <td>文件大小</td>
                                             <td>上传进度</td>
                                             <td>上传速度</td>
                                             <td>操作</td>
                                         </tr>
                                     </table>
                                    <p class="test5">或将文件拖到这里，单次最多可选300张</p>
                                     <div id="fileQueueList" class="fileQueueList">

                                     </div>
                                     <div style="margin-top: 15px">
                                        <img id="dndArea" class="placeholder"
                                          src="../../../../../libs/img/webuploader/image_upload.jpg">
                                     </div>
                                 </div>
                            </div>
                            <div class="statusBar" style="display:none;">
                                <div class="progress">
                                    <span class="text">0%</span>
                                    <span class="percentage"></span>
                                </div>
                                <div class="info"></div>
                                <div class="btns">
                                    <div id="filePicker2"></div>
                                    <div class="uploadBtn">开始上传</div>
                                    <button id="correctFile" type="button" class="btn btn-success btn-clean" onclick="returnEdit(this)" >确定</button>
                                    <button id="closeFile" type="button" class="btn btn-default btn-clean" onclick="returnEdit(this)">关闭</button>
                                </div>
                            </div>
                            <div id="beforeReady" class="modal-footer">
                                <button id="correctFile2" type="button" class="btn btn-success btn-clean" onclick="returnEdit(this)" >确定</button>
                                <button id="closeFile2" type="button" class="btn btn-default btn-clean" onclick="returnEdit(this)">关闭</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var arrayFiles = new Array;
    });
    $(function () {
        if(flagEdit){
            for(var i = 0 ; i < p_fileLength ; i++){
                $("#fileQueueList").append(
                    '<div class="border2">'+
                    '<img class="file_img" src="'+p_fileUrl[i]+'">'+
                    '<p class="test3">'+p_fileName[i]+'</p></div>'
                );
            }
        }
    });
    function downFilesBtn(e) {
        var f_id = $(e).parent().parent().children("td").eq(0).text();
        var f_name = $(e).parent().parent().children("td").eq(1).text();
        var f_type = $(e).parent().parent().children("td").eq(2).text();
        $.ajax({
            type:"GET",
            url:"<%=request.getContextPath()%>/files/downloadFiles",
            data:{
                f_id: f_id,
                f_name: f_name,
                f_type: f_type
            },
            error: function(request) {
                swal({title: "下载连接失败！", type: "error"});
                //alert("下载连接失败");
            },
            success:function (data) {
                return data;
            }
        });
    }


    /*returnEdit公共方法*/
    function commonReturn() {
        $("#dialogFile").modal("hide");
        $("#dialog").modal("show");
        $(".modal-backdrop").remove();//删除class值为modal-backdrop的标签，可去除阴影
    }
    function returnEdit(id) {
        if(id.id == "closeFile"||id.id == "closeFile2"){
            commonReturn();
        }else{
            if (fileFlag) {
                $("#picture").text("已选择文件");
                /*$("#picture").text("已选择图片");*/
                $("#picture").attr("onclick","upload_choosePic()");
                commonReturn();
            }else{
                swal({
                    title: "请选择上传的图片!",
                    type: "info"
                });
                //alert("请选择上传的图片！");
                return;
            }
        }
    }
</script>




