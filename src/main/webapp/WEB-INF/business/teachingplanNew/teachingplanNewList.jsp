<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                    <div class="block block-drop-shadow">
                        <div class="content block-fill-white">
                            <div class="form-row">
                                <div class="col-md-1 tar">
                                    学期
                                </div>
                                <div class="col-md-2">
                                    <select id="s_term" class="validate[required,maxSize[20]] form-control"/>
                                </div>
                                <div class="col-md-1 tar">
                                    教师姓名
                                </div>
                                <div class="col-md-2">
                                    <input id="s_person" type="text"
                                           class="validate[required,maxSize[20]] form-control"/>
                                </div>
                                <div class="col-md-1 tar">
                                    状态
                                </div>
                                <div class="col-md-2">
                                    <select id="s_status" selected="true" class="validate[required,maxSize[20]] form-control">
                                        <option value="">请选择</option>
                                        <option value="0">未上传</option>
                                        <option value="1">已上传</option>
                                        <option value="2">待审核</option>
                                        <option value="3">审核通过</option>
                                        <option value="4">审核未通过</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-1 tar">
                                    系部
                                </div>
                                <div class="col-md-2">
                                    <select id="s_dept" onchange="changeMajor()" class="validate[required,maxSize[20]] form-control"/>
                                </div>
                                <div class="col-md-1 tar">
                                    专业
                                </div>
                                <div class="col-md-2">
                                    <select id="s_major" onchange="changeClass()" class="validate[required,maxSize[20]] form-control"/>
                                </div>
                                <div class="col-md-1 tar">
                                    班级
                                </div>
                                <div class="col-md-2">
                                    <select id="s_class" class="validate[required,maxSize[20]] form-control"/>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="search()">查询
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="searchclear()">清空
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                <div class="block block-drop-shadow content">
                    <%--<c:if test="${type != 1}">--%>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean" onclick="add()">新增</button>
                            <button type="button" class="btn btn-default btn-clean" onclick="toImportData()">课程表导入
                            </button>
                            <br>
                        </div>
                    <%--</c:if>--%>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_term');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 's_dept');
        });
        $("#s_major").append("<option value='' selected>请选择</option>")
        $("#s_class").append("<option value='' selected>请选择</option>")
        search();
    });

    function audit(id,status) {
        if(4 == status || 3 == status){
            swal({
                title: "不能重复审核",
                type: "error"
            })
        }else if (status==0 || status == 1){
            swal({
                title: "申请提交后，才能审核",
                type: "error"
            })
        }
        else{
            $("#dialog").load("<%=request.getContextPath()%>/teachingplanNew/toAudit?id=" + id);
            $("#dialog").modal("show")
        }

    }

    function upload(dataId,status) {
        if (status == 0 || status == 1 || status == 4) {
            $("#dialog").load("<%=request.getContextPath()%>/teachingplanNew/toUpload?id=" + dataId);
            $("#dialog").modal("show")
        }else if (status == 2) {
            swal({
                title: "待审核，无法上传文件",
                type: "warning"
            })
        }else {
            swal({
                title: "已审核，无法上传文件",
                type: "warning"
            })
        }
    }
    function changeMajor() {
        var deptId = $("#s_dept").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 's_major');
        });
    }

    function changeClass() {
        var majorCode = $("#s_major").val();
        var arr = majorCode.split(",");
        $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + arr[0] + "&trainingLevel=" + arr[1], function (data) {
            addOption(data, 's_class');
        });
    }
    function download(url) {
        if(url == null || url=='null'){
            swal({
                title: "无附件可下载！",
                type: "info"
            });
        }else {
            window.location.href = "<%=request.getContextPath()%>" + url;
        }
    }

    function toImportData() {
        $("#dialog").load("<%=request.getContextPath()%>/teachingplanNew/toImportData");
        $("#dialog").modal("show")
    }

    function submit(dataId, status) {
        console.log(status)
        if (status == "0") {
            swal({
                title: "请先上传文件！",
                type: "info"
            });

        } else if (status == '2') {
            swal({
                title: "已经提交审核，无需重复提交！",
                type: "info"
            });
        } else if (status == '3') {
            swal({
                title: "审核已通过，无需再次提交审核！",
                type: "info"
            });
        } else {
            $.post("<%=request.getContextPath()%>/teachingplanNew/submit", {
                id: dataId
            }, function () {
                swal({
                    title: "提交成功！",
                    type: "info"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        }

    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teachingplanNew/toTeachingplanNewAdd")
        $("#dialog").modal("show")
    }

    function edit(id,status) {
        if (status == 0 || status == 1 || status == 4) {
            $("#dialog").load("<%=request.getContextPath()%>/teachingplanNew/toTeachingplanNewEdit?id=" + id)
            $("#dialog").modal("show")
        }else if (status == 2){
            swal({
                title: "待审核，无法修改",
                type: "warning"
            })
        }else{
            swal({
                title: "已审核，无法修改",
                type: "warning"
            })
        }
    }

    function del(id,status) {
        if (status==0 || status == 1 || status == 4 || status == 2) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/teachingplanNew/delTeachingplanNew?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
     }else {
            swal({
                title: "已审核，无法删除",
                type: "warning"
            })
        }
    }
    function del2(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/teachingplanNew/delTeachingplanNew?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
    function searchclear() {
        $("#s_term").val("");
        $("#s_person").val("");
        $("#s_status").val("");
        $("#s_dept").val("");
        $("#s_major").val("");
        $("#s_class").val("");
        $("#s_term option:selected").val("");
        $("#s_status option:selected").val("");
        $("#s_dept option:selected").val("");
        $("#s_major option:selected").val("");
        $("#s_class option:selected").val("");
        search();
    }
    function search() {
        var terms =$("#s_term option:selected").val();
        var persons = $("#s_person").val();
        var statuss = $("#s_status option:selected").val();
        var depts = $("#s_dept option:selected").val();
        var majors = $("#s_major option:selected").val();
        var classs = $("#s_class option:selected").val();
        if(terms==""|| terms == undefined){
            terms = "";
        }
        if(persons==""|| persons == undefined){
            persons = "";
        }
        if(statuss==""|| statuss == undefined){
            statuss = "";
        }
        if(depts==""|| depts == undefined){
            depts = "";
        }
        if(majors==""|| majors == undefined){
            majors = "";
        }
        if(classs==""|| classs == undefined){
            classs = "";
        }


        $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teachingplanNew/getTeachingplanNewList?type=${type}',
                "data": {
                    term:terms,
                    person:persons,
                    status:statuss,
                    departmentsId:depts,
                    majorId:majors,
                    classId:classs,
                    type:'${type}'
                }
            },
            "destroy": true,
            "columns": [
                {"data": "term", "title": "学期"},
                {"data": "userId", "title": "教师姓名"},
                {"data": "deptId", "title": "教师所属系部"},
                {"data": "departmentsId", "title": "系部"},
                {"data": "majorId", "title": "专业"},
                {"data": "courseId", "title": "课程"},
                {"data": "classId", "title": "班级"},
                {"data": "period", "title": "学时"},
                {
                    "data": "status",
                    "title": "状态",
                    "render": function (data, type, row) {
                        switch (row.status) {
                            case '0':
                                return "未上传";
                            case '1':
                                return "已上传";
                            case '2':
                                return "待审核";
                            case '3':
                                return "审核通过";
                            case '4':
                                return "审核未通过";
                        }
                    }
                },
                {"data": "opinion", "title": "意见","width":"25%"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        if("${roleEmpDeptRelation}"==null||"${roleEmpDeptRelation}"==""||"${roleEmpDeptRelation}"==undefined){
                            var html = '<span class="icon-upload" title="上传附件" onclick=upload("' + row.id + '",' + row.status + ')></span>&ensp;&ensp;' +
                                '<span class="icon-upload-alt" title="提交审核" onclick=submit("' + row.id + '","' + row.status + '")></span>&ensp;&ensp;'+
                                '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '",' + row.status + ')></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '",' + row.status + ')></span>';
                        }else{
                            var html = '<span class="icon-upload" title="上传附件" onclick=upload("' + row.id + '",' + row.status + ')></span>&ensp;&ensp;' +
                                '<span class="icon-upload-alt" title="提交审核" onclick=submit("' + row.id + '","' + row.status + '")></span>&ensp;&ensp;' +
                                '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '",' + row.status + ')></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del2("' + row.id + '")></span>&ensp;&ensp;'+
                            '<span class="icon-download" title="下载附件" onclick=download("' + row.url + '")></span>&ensp;&ensp;' +
                            '<span class="icon-file-text-alt" title="审核" onclick=audit("' + row.id + '","' + row.status + '")></span>&ensp;&ensp;';
                        }
                       /* if ("${type}" == 1) {
                            html = '<span class="icon-download" title="下载附件" onclick=download("' + row.url + '")></span>&ensp;&ensp;' +
                                '<span class="icon-edit" title="审核" onclick=audit("' + row.id + '","' + row.status + '")></span>&ensp;&ensp;'
                        }*/
                        return html;
                    }
                }
            ],
            'order': [0, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
</script>