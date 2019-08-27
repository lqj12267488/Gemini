<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white" style="width: 165%;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeWind()">
                &times;
            </button>
            <h4 class="modal-title"> &nbsp;</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <button onclick="doPrint()" class="btn btn-default btn-clean" id="dayin">打印</button>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        标题 :
                    </div>
                    <div class="col-md-10">${notice.title}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        类型 :
                    </div>
                    <div class="col-md-4">${notice.typeShow}
                    </div>
                    <div class="col-md-2 tar">
                        发送者 :
                    </div>
                    <div class="col-md-4">${notice.creator}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        内容 :
                    </div>
                    <div class="col-md-10">
                        <%--<textarea name="intro" cols="25" rows="15" readonly="readonly"--%>
                                  <%--style="font-size: 16px;">${notice.content}</textarea>--%>
                            <pre style="height: auto;">${notice.content}</pre>


                    </div>
                </div>
                <div id="file" class="form-row">
                    <div class="col-md-2 tar">
                        附件 :
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeWind()">关闭
            </button>
            </button>
        </div>
    </div>
</div>
<input id="id" hidden value="${notice.id}">
<input id="nottype" hidden value="${notice.type}">
<input id="type" hidden value="${type}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/notice/printNotice?id=${notice.id}">
<script>
    var type=$("#type").val();
    $("#business").load('${url}')
    $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
        businessId: $("#id").val(),
    }, function (data) {
        if (data.data.length == 0) {
            $("#file").append('<div>' +
                '<div class="col-md-2 tar"></div>' +
                '<div class="col-md-9">' +
                '无' +
                '</div>' +
                '</div>')
        } else {
            $.each(data.data, function (i, val) {
                $("#file").append('<div>' +
                    '<div class="col-md-2 tar"></div>' +
                    '<div class="col-md-9">' +
                    '<a href="' + '<%=request.getContextPath()%>/files/downloadFiles?id='+val.fileId + '" target="_blank">' + val.fileName + '</a>' +
                    '</div>' +
                    '</div>');
            })
        }
    })
    $(document).ready(function () {
        var $textarea = $('textarea[name=intro]');
        var html = $textarea.val();
        $textarea.val($(html).text());
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GGLX", function (data) {
            addOption(data, "type", "${notice.type}");
        })

    })

    function yesReaded() {
        var id = $("#id").val();
        var type = $("#nottype").val();
        swal({
            title: "确定将本条公告标记为已读?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/insertNoticeLog", {
                noticeID: id,
                type: type
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"}, function () {
                        //$("#eChartsP").reload("<%=request.getContextPath()%>/index");
                     /*   window.location.href = "<%=request.getContextPath()%>/index?system=GLPT&id=001";*/
                        window.location.reload();
                        window.close();
                    });
                }


            });
        })
    }

    function closeWind() {
            if(type==0){
                $("#indexNList").load("<%=request.getContextPath()%>/noticeListIndexNotice?loginID=${notice.requester}");
            }
            if(type==1){
                $("#right").load("<%=request.getContextPath()%>/noticeListPerson");
            }
            if(type==2) {
                $("#dialog").load("<%=request.getContextPath()%>/loadMoreNotices");
            }
    }

    function doPrint() {
        if(type==2){
            $("#dialogFile").modal("hide");
        }else {
            $("#dialog").modal("hide");
        }
        var iframe=document.getElementById("print-iframe");
        if(!iframe){
            //var el = document.getElementById("printcontent");

            iframe = document.createElement('IFRAME');
            var doc = null;
            iframe.setAttribute("id", "print-iframe");
            iframe.setAttribute('style', 'position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
            document.body.appendChild(iframe);
        }
        $.get($("#printFunds").val(), function (html) {
            console.log(html);
            doc = iframe.contentWindow.document;
            //这里可以自定义样式
            //doc.write("<LINK rel="stylesheet" type="text/css" href="css/print.css">");
            doc.write('<div>' + html + '</div>');
            doc.close();
            iframe.contentWindow.focus();
            iframe.contentWindow.print();
        })
        //var bdhtml = window.document.body.innerHTML;
       /* $.get("<%=request.getContextPath()%>/notice/printNotice?id=${notice.id}", function (html) {
            window.document.body.innerHTML = html;
            window.print();
            window.document.body.innerHTML = bdhtml;*/
            if(type==0){
                $("#indexNList").load("<%=request.getContextPath()%>/noticeListIndexNotice?loginID=${notice.requester}");
            }
            if(type==1){
                $("#right").load("<%=request.getContextPath()%>/noticeListPerson");
            }
            if(type==2) {
                $("#dialog").load("<%=request.getContextPath()%>/loadMoreNotices");
            }
        //})
    }
</script>