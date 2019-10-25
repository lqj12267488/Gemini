<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="pERSONID" hidden value="${data.personid}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 姓名
                    </div>
                    <div class="col-md-9">
                        <input id="person" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[100]] form-control" value="${data.person}"/>
                        <input id="perId" type="hidden" value="${data.person}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>等级
                    </div>
                    <div class="col-md-9">
                        <select id="gradeEdit" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>名称
                    </div>
                    <div class="col-md-9">
                        <input id="givennameEdit" value="${data.givenname}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>发证单位
                    </div>
                    <div class="col-md-9">
                        <input id="issuerEdit" value="${data.issuer}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获取日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="getdateEdit" value="${data.getDateStr}"/>
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>从事教学管理年限
                    </div>
                    <div class="col-md-9">
                        <input id="teachingmanagementEdit" value="${data.teachingmanagement}"/>
                    </div>
                </div>--%>
                <input id="id" value="${data.id}" hidden>
               <%-- <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>从事学生管理年限
                    </div>
                    <div class="col-md-9">
                        <input id="studentmanagementEdit" value="${data.studentmanagement}"/>
                    </div>
                </div>--%>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否专职政治辅导员
                    </div>
                    <div class="col-md-9">

                        <select id="politicalcounselorEdit">
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select>
                    </div>
                </div>--%>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否专职心理咨询师
                    </div>
                    <div class="col-md-9">
                        &lt;%&ndash;<input id="psychologicalconsultantEdit" value="${data.psychologicalconsultant}"/>&ndash;%&gt;
                            <select id="psychologicalconsultantEdit">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>从事招生就业工作年限
                    </div>
                    <div class="col-md-9">
                        <input id="employmentofficeEdit" value="${data.employmentoffice}"/>
                    </div>
                </div>
                <%--
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业领域
                    </div>
                    <div class="col-md-9">
                        <input id="expertiseEdit" value="${data.expertise}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>周工作小时数
                    </div>
                    <div class="col-md-9">
                        <input id="workinghoursEdit" value="${data.workinghours}"/>
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>岗位职能
                    </div>
                    <div class="col-md-9">
                        <input id="postfunction" value="${data.postfunction}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>本岗位工作年限
                    </div>
                    <div class="col-md-9">
                        <input id="workingyears" value="${data.workingyears}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        //部门多选树，初始化
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var node;
            var lis = $("#deptId").val().split(",");
            //设置选择节点
            for (var i = 0; i < lis.length; i++) {
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#" + lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });

        //经办人自动提示框
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label.split("  ----  ")[0]);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYDJ", function (data) {
            addOption(data, 'gradeEdit', '${data.grade}');
        });
    })

    function save() {

        if ($("#gradeEdit").val() == "" || $("#gradeEdit").val() == undefined || $("#gradeEdit").val() == null) {
            swal({
                title: "请填写等级！",
                type: "warning"
            });
            return;
        }
        if ($("#givennameEdit").val() == "" || $("#givennameEdit").val() == undefined || $("#givennameEdit").val() == null) {
            swal({
                title: "请填写名称！",
                type: "warning"
            });
            return;
        }
        if ($("#issuerEdit").val() == "" || $("#issuerEdit").val() == undefined || $("#issuerEdit").val() == null) {
            swal({
                title: "请填写发证单位！",
                type: "warning"
            });
            return;
        }
        if ($("#getdateEdit").val() == "" || $("#getdateEdit").val() == undefined || $("#getdateEdit").val() == null) {
            swal({
                title: "请填写获取日期！",
                type: "warning"
            });
            return;
        }
        /*if ($("#teachingmanagementEdit").val() == "" || $("#teachingmanagementEdit").val() == undefined || $("#teachingmanagementEdit").val() == null) {
            swal({
                title: "请填写从事教学管理年限！",
                type: "warning"
            });
            return;
        }*/
        /*if ($("#studentmanagementEdit").val() == "" || $("#studentmanagementEdit").val() == undefined || $("#studentmanagementEdit").val() == null) {
            swal({
                title: "请填写从事学生管理年限！",
                type: "warning"
            });
            return;
        }
        if ($("#politicalcounselorEdit").val() == "" || $("#politicalcounselorEdit").val() == undefined || $("#politicalcounselorEdit").val() == null) {
            swal({
                title: "请填写是否专职政治辅导员",
                type: "warning"
            });
            return;
        }
        if ($("#psychologicalconsultantEdit").val() == "" || $("#psychologicalconsultantEdit").val() == undefined || $("#psychologicalconsultantEdit").val() == null) {
            swal({
                title: "请填写是否专职心理咨询师",
                type: "warning"
            });
            return;
        }*/

        if ($("#employmentofficeEdit").val() == "" || $("#employmentofficeEdit").val() == undefined || $("#employmentofficeEdit").val() == null) {
            swal({
                title: "请填写从事招生就业工作年限！",
                type: "warning"
            });
            return;
        }
        if ($("#postfunction").val() == "" || $("#postfunction").val() == undefined || $("#postfunction").val() == null) {
            swal({
                title: "请填写岗位职能！",
                type: "warning"
            });
            return;
        }
        if ($("#workingyears").val() == "" || $("#workingyears").val() == undefined || $("#workingyears").val() == null) {
            swal({
                title: "请填写本岗位工作年限！",
                type: "warning"
            });
            return;
        }
        /*
        if ($("#expertiseEdit").val() == "" || $("#expertiseEdit").val() == undefined || $("#expertiseEdit").val() == null) {
            swal({
                title: "请填写专业领域！",
                type: "warning"
            });
            return;
        }
        if ($("#workinghoursEdit").val() == "" || $("#workinghoursEdit").val() == undefined || $("#workinghoursEdit").val() == null) {
            swal({
                title: "请填写周工作小时数！",
                type: "warning"
            });
            return;
        }*/
        $.post("<%=request.getContextPath()%>/Staff/saveStaff", {
            id:$("#id").val(),
            personid: "${data.personid}",
            personidvalue: $("#perId").val().split(",")[1],
            grade: $("#gradeEdit").val(),
            givenname: $("#givennameEdit").val(),
            issuer: $("#issuerEdit").val(),
            getdate: $("#getdateEdit").val(),
            postfunction:$("#postfunction").val(),
            workingyears:$("#workingyears").val(),
            type:"3",
            /*teachingmanagement: $("#teachingmanagementEdit").val()*/
            /*studentmanagement: $("#studentmanagementEdit").val(),
            politicalcounselor: $("#politicalcounselorEdit").val(),
            psychologicalconsultant: $("#psychologicalconsultantEdit").val(),*/

            employmentoffice: $("#employmentofficeEdit").val(),
            /*
           expertise: $("#expertiseEdit").val(),
           workinghours: $("#workinghoursEdit").val(),*/
        }, function (msg) {
            swal({
                title: msg.msg,
                type: msg.result
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>



