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
                                计划名称：
                            </div>
                            <div class="col-md-2">
                                <input id="name" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="ss_term" />
                            </div>
                            <div class="col-md-1 tar">
                                创建年份：
                            </div>
                            <div class="col-md-2">
                                <select id="ss_year" />
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="add()">新增
                            </button>
                            <br>
                        </div>
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

</div>

<input id="tableName" hidden value="T_JW_TEACHINGPLAN">
<input id="workflowCode" hidden value="T_JW_TEACHINGPLAN01">
<input id="businessId" hidden>
<script>
    var table;
    $(document).ready(function () {
        $.get("/common/getSysDict?name=ND", function (data) {
            addOption(data, 'ss_year');
        });
        $.get("/common/getSysDict?name=KKJHXQ", function (data) {
            addOption(data,'ss_term');
        });
        search();
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teachingPlan/toAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/teachingPlan/toEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            //text: "评教方案名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/teachingPlan/del?id=" + id, function (data) {
                swal({title: data.msg, type: data.result});
                $('#table').DataTable().ajax.reload();
            })
        })
    }

    function toPlanDetail(id,planName) {
        $("#right").load("<%=request.getContextPath()%>/teachingPlanDetail/toList?planId=" + id + "&planName="+planName);
    }

    function submit(id) {
        $("#businessId").val(id);
        getAuditer();

    }
    function upload(id){
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_TEACHINGPLAN');
        $('#dialogFile').modal('show');
    }
    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
    }
    function searchclear() {
        $("#name").val("");
        $("#ss_term").val("");
        $("#ss_year").val("");
        search();
    }
    function search() {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teachingPlan/getList',
                "data":{
                    planName: $("#name").val(),
                    year: $("#ss_year").val(),
                    term:$("#ss_term").val()
                }
            },
            "destroy": true,
            "columns": [
                {"width": "12%", "data": "planName", "title": "计划名称"},
                {"width": "10%", "data": "departmentsId", "title": "系部名称"},
                {"width": "12%", "data": "majorCode", "title": "专业名称"},
                {"width": "12%", "data": "courseId", "title": "课程名称"},
                {"width": "12%", "data": "textbookId", "title": "教材名称"},
                {"width": "12%", "data": "year", "title": "创建年份"},
                {"width": "10%", "data": "className", "title": "班级名称"},
                {"width": "10%", "data": "term", "title": "学期"},
                {"width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-cloud-upload" title="上传附件"onclick=upload("' + row.id + '")/>&ensp;&ensp;'+
                           '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-upload-alt" title="提交" onclick=submit("' + row.id + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    }
    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }
        }
        if(personId == '' || personId==null || personId=="" || personId==undefined)
        {
            swal({
                title: "请选择办理人!",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_JW_TEACHINGPLAN",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal("hide");
                    $('#table').DataTable().ajax.reload();
                }
            }
        )
    }
</script>