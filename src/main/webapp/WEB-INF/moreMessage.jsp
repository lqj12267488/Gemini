<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog" style="width: 1200px">
    <div class="row">
        <div class="col-md-12">
            <div >
                <div class="modal-header">
                    <button type="button"  class="close" data-dismiss="modal" aria-hidden="true" onclick="closeMore()">
                        &times;
                    </button>
                    <h4 class="modal-title">查看通知</h4>
                </div>
                <div class="modal-body clearfix">
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active"><a href="#tab10" data-toggle="tab">未读</a></li>
                        <li><a href="#tab11" data-toggle="tab">已读</a></li>
                    </ul>
                    <div class="content tab-content">
                        <div class="tab-pane active" id="tab10">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="unRead" cellpadding="0" cellspacing="0" width="100%"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab11">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="readed" cellpadding="0" cellspacing="0" width="100%"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var unRead;
    var readed;
    $(document).ready(function () {
        unRead = $("#unRead").DataTable({
            "data": ${messageList},
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "abc", "visible": false},
                {"width": "80%", "data": "typeShow", "title": "标题"},
                {"width": "12%", "data": "publicTime", "title": "发布时间"},
                {"width":"8%","title": "操作","render": function () {return "<a id='detail' class='icon-search' title='查看'></a>";}}
            ],
            'order' : [[3,'desc']],
            "dom": 'rtlip',
            "language": language
        });

        readed = $("#readed").DataTable({
            "data": ${messageReaded},
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "abc", "visible": false},
                {"width": "80%", "data": "typeShow", "title": "标题"},
                {"width": "12%", "data": "publicTime", "title": "发布时间"},
                {"width":"8%","title": "操作","render": function () {return "<a id='detail' class='icon-search' title='查看'></a>";}}
            ],
            'order' : [3,'desc'],
            "dom": 'rtlip',
            language: language
        });
        unRead.on('click', 'tr a', function () {
            var data = unRead.row($(this).parent()).data();
            var id = data.id;
            var type=data.abc;
            if (this.id == "detail") {
                if(type=="1"){
                    $("#dialogFile").load("<%=request.getContextPath()%>/indexGetNoticeById?id=" + id +"&type=" +'2');
                }else{
                    $("#dialogFile").load("<%=request.getContextPath()%>/messageInfo?id=" + id +"&type=" +'2');
                }
                $("#dialogFile").modal("show");
            }
        });
        readed.on('click', 'tr a', function () {
            var data = readed.row($(this).parent()).data();
            var id = data.id;
            var type=data.abc;
            if (this.id == "detail") {
                if(type=="1"){
                    $("#dialogFile").load("<%=request.getContextPath()%>/indexGetMoreNoticeById?id=" + id);
                }else{
                    $("#dialogFile").load("<%=request.getContextPath()%>/moreMessageInfo?id=" + id);
                }
                $("#dialogFile").modal("show");
            }
        });

    })


    function getView(id, resultType) {
        if (resultType == 1 || resultType == '1') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/project", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 2 || resultType == '2') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/standard", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 3 || resultType == '3') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/medicine", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 4 || resultType == '4') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/paper", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 5 || resultType == '5') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/art", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 6 || resultType == '6') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/guide", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 7 || resultType == '7') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/writing", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 8 || resultType == '8') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/patent", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 9 || resultType == '9') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/report", {
                id: id,
                flag: "on"
            });
        }
        $("#dialog").modal("show");
    }
    function closeMore() {
        window.location.reload();
    }
</script>


