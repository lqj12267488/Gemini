<%-- Created by IntelliJ IDEA. User: Administrator Date: 2017/5/24 Time: 15:05 To change this template use File | Settings | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css"> textarea {
        resize: none;
    }</style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <span style="font-size: 14px;">人才培养维护</span><input id="id" hidden value="${tt.id}"/></div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <%--<div class="form-row">--%>
                <%--<div class="col-md-3 tar"><span class="iconBtx">*</span>方案名称</div>--%>
                <%--<div class="col-md-9">--%>
                <%--<div><input id="planname" type="text" value="${tt.planName}"/></div>--%>
                <%--</div>--%>
                <%--</div>--%>
                <form id="trainForm"
                      enctype="multipart/form-data"
                      method="post">
                    <div class="form-row">
                        <div class="col-md-4 tar"><span class="iconBtx">*</span>系部</div>
                        <div class="col-md-8"><select id="departmentsId" name="departmentsId" onchange="changeMajor();allChange(this)"/></div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar"><span class="iconBtx">*</span>专业</div>
                        <div class="col-md-8"><select id="majorid" onchange="allChange()" name="majorid"/></div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar"><span class="iconBtx">*</span>年份</div>
                        <div class="col-md-8"><select id="yeartype" name="yeartype" onchange="allChange()"/></div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar"><span class="iconBtx">*</span>培养模式</div>
                        <div class="col-md-8"><input id="trainMode" name="trainMode" placeholder="例如：2+1" value="${tt.trainMode}"/></div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar"><span class="iconBtx">*</span>适用学院</div>
                        <div class="col-md-8">
                            <select id="suitSchool" name="suitSchool" value="${tt.suitSchool}">
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar"><span class="iconBtx">*</span>执行年级</div>
                        <div class="col-md-8"><input id="actionGrade" placeholder="例如：2017级、2018级"
                                     name="actionGrade" value="${tt.actionGrade}"/></div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar">人才培养方案</div>
                        <div class="col-md-8">
                            <input id="trainPlan" readonly="readonly" type="text" value="${tt.trainPlan}"
                                name="trainPlan"    placeholder="请选择系部、专业、年份"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar">教学活动时间安排表</div>
                        <div class="col-md-8">
                            <input id="teachFile" name="teachFile" type="file"/>
                        </div>
                        <div id="file" class="form-row">
                            <div class="col-md-4 tar">
                                附件
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar">课程设置、教学进度计划及课时分配表</div>
                        <div class="col-md-8">
                            <input id="distributeFile" name="distributeFile" type="file"/>
                        </div>
                        <div id="file1" class="form-row">
                            <div class="col-md-4 tar">
                                附件
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar">实践教学活动安排表</div>
                        <div class="col-md-8">
                            <input id="practiceFile" name="practiceFile" type="file"/>
                        </div>
                        <div id="file2" class="form-row">
                            <div class="col-md-4 tar">
                                附件
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script> $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
$(document).ready(function () {
    $.post("<%=request.getContextPath()%>/major/getFilesByFileId", {
        fileId: '${tt.teachFile11}',
    }, function (data) {
        if (data.data.length == 0) {
            $("#file").append('<div class="form-row">' +
                '<div class="col-md-4 tar"></div>' +
                '<div class="col-md-8">' +
                '无' +
                '</div>' +
                '</div>')
        } else {
            $.each(data.data, function (i, val) {
                $("#file").append('<div class="form-row">' +
                    '<div class="col-md-4 tar"></div>' +
                    '<div class="col-md-8">' +
                    '<a href="' +'<%=request.getContextPath()%>'+ val.fileUrl + '" target="_blank">' + val.fileName + '</a>' +
                    '</div>' +
                    '</div>');
            })
        }
    })
    $.post("<%=request.getContextPath()%>/major/getFilesByFileId", {
        fileId: '${tt.distributeFile}',
    }, function (data) {
        if (data.data.length == 0) {
            $("#file1").append('<div class="form-row">' +
                '<div class="col-md-4 tar"></div>' +
                '<div class="col-md-8">' +
                '无' +
                '</div>' +
                '</div>')
        } else {
            $.each(data.data, function (i, val) {
                $("#file1").append('<div class="form-row">' +
                    '<div class="col-md-4 tar"></div>' +
                    '<div class="col-md-8">' +
                    '<a href="' +'<%=request.getContextPath()%>'+ val.fileUrl + '" target="_blank">' + val.fileName + '</a>' +
                    '</div>' +
                    '</div>');
            })
        }
    })
    $.post("<%=request.getContextPath()%>/major/getFilesByFileId", {
        fileId: '${tt.practiceFile}',
    }, function (data) {
        if (data.data.length == 0) {
            $("#file2").append('<div class="form-row">' +
                '<div class="col-md-4 tar"></div>' +
                '<div class="col-md-8">' +
                '无' +
                '</div>' +
                '</div>')
        } else {
            $.each(data.data, function (i, val) {
                $("#file2").append('<div class="form-row">' +
                    '<div class="col-md-4 tar"></div>' +
                    '<div class="col-md-8">' +
                    '<a href="' +'<%=request.getContextPath()%>'+ val.fileUrl + '" target="_blank">' + val.fileName + '</a>' +
                    '</div>' +
                    '</div>');
            })
        }
    })


    var id = $("#id").val();
    var flag;
    //系部
    $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
        addOption(data, 'departmentsId', '${tt.departmentsId}');
    });
    //年份 yearType
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
        addOption(data, 'yeartype', '${tt.yearType}');
    });

    //适用学院
    $.get("<%=request.getContextPath()%>/common/getSysDictSelect?name=XY", function (data) {
        addOption(data, 'suitSchool', '${tt.suitSchool}');
    });
    //专业
    if ('${tt.majorId}' != "") {
        var deptId = '${tt.departmentsId}';
        $.get("<%=request.getContextPath()%>/course/getMajorByDepId?deptId=" + deptId, function (data) {
            addOption(data, 'majorid', '${tt.majorId}');
        });
    } else {
        $("#majorCodeSearch").append("<option value='' selected>请选择</option>")
    }
});

function changeMajor() {
    var deptId = $("#departmentsId").val();
    $.get("<%=request.getContextPath()%>/course/getMajorByDepId?deptId=" + deptId, function (data) {
        addOption(data, 'majorid');
    });
}


function save() {
    var majorid = $("#majorid").val();
    //var planName = $("#planname").val();
    var yearType = $("#yeartype option:selected").val();
    var trainPlan = $("#trainPlan").val();
    var trainMode = $("#trainMode").val();
    var suitSchool = $("#suitSchool").val();
    var actionGrade = $("#actionGrade").val();
    var trainPlan = $("#trainPlan").val();

    var trainForm=new FormData(document.getElementById("trainForm"));

    var distributeFile = document.getElementById("distributeFile");
    var distributeFileUrl = $("#distributeFile").val();
    var distributeFile_end = distributeFileUrl.split(".");

    var teachFile = document.getElementById("teachFile");
    var teachFileUrl = $("#teachFile").val();
    var teachFile_end = teachFileUrl.split(".");

    var practiceFile = document.getElementById("practiceFile");
    var practiceFileUrl = $("#practiceFile").val();
    var practiceFile_end = practiceFileUrl.split(".");

    if ((distributeFile_end[1] == 'bat' || distributeFile_end[1] == "exe")
        || (teachFile[1] == 'bat' || teachFile[1] == "exe")
        || (practiceFile[1] == 'bat' || practiceFile[1] == "exe")) {
        swal({title: "不可上传可执行文件！", type: "info"});
        return;
    }
    if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
        swal({
            title: "请选择系部！",
            type: "info"
        });
        return;
    }
    if (majorid == "" || majorid == undefined || majorid == null) {
        swal({
            title: "请选择专业！",
            type: "info"
        });
        return;
    }
    if (yearType == "" || yearType == undefined || yearType == null) {
        swal({
            title: "请选择年份！",
            type: "info"
        });
        return;
    }
    if (trainMode == "" || trainMode == undefined || trainMode == null) {
        swal({
            title: "请填写培养模式！",
            type: "info"
        });
        return;
    } else {
        var reg = /^[0-9]{1,}[\+][0-9]{1,}$/;
        if (!reg.test(trainMode)) {
            swal({
                title: "请参照提示的培养模式格式填写！",
                type: "info"
            });
            return;
        }
    }
    if (suitSchool == "" || suitSchool == undefined || suitSchool == null) {
        swal({
            title: "请填写适用学院！",
            type: "info"
        });
        return;
    }
    if (actionGrade == "" || actionGrade == undefined || actionGrade == null ||  actionGrade.indexOf("【")>-1) {
        swal({
            title: "请填写执行年级",
            type: "info"
        });
        return;
    } else {
        //判断输入的是否符合规范 例如：2014级、2015级
        var reg = /^[0-9]{4}[\u7ea7](([\u3001][0-9]{4}[\u7ea7])+|)/;
        var reg1 = /[\u3001]$/;
        var temp1 = reg.test(actionGrade);
        var temp2 = !(reg1.test(actionGrade));
        if (!(temp1 && temp2)) {
            swal({
                title: "请参照提示的执行年级格式填写！",
                type: "info"
            });
            return;
        }
    }
    if (trainPlan == "" || trainPlan == undefined || trainPlan == null) {
        swal({
            title: "请填写人才培养方案",
            type: "info"
        });
        return;
    }
    showSaveLoading();
    
    $.ajax({
        url: '<%=request.getContextPath()%>/major/saveTalent?' +
            'id=' + $("#id").val() + '&majorId=' + majorid + "&yearType=" + yearType + "&departmentsId=" + $("#departmentsId option:selected").val() +
            "&trainPlan=" + trainPlan + "&suitSchool=" + suitSchool + "&actionGrade=" + actionGrade + "&trainMode=" + trainMode,
        type: "post",
        processData: false,
        contentType: false,
        data: trainForm,
        success: function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: msg.status==0?'error':"success"
            });
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        }
    });


}

function allChange(ele) {
    var yearType = $("#yeartype option:selected").text();
    var departmentsId = $("#departmentsId option:selected").text();
    var majorid = '';
    if(ele!=undefined){
        majorid='';
    }else {
        majorid=$("#majorid option:selected").text();
    }
    document.getElementById("trainPlan").value = judge(yearType, 1) + judge(departmentsId, 2) + judge(majorid, 3);
}

function judge(val,temp) {
    var tag='';
    switch (temp) {
        case 1:
            tag='【年份】'
            break;
        case 2:
            tag='【系部】';
            break;
        case 3:
            tag='【专业】';
            break;
    }
    return (val=='请选择'||val==''||val=='无数据')?tag:val;
}

function addMajorOption(data, select, selected) {
    $("#" + select).html("");
    if (selected === undefined) {
        $("#" + select).append("<option value='' selected>请选择</option>")
    } else {
        $("#" + select).append("<option value=''>请选择</option>")
    }

    $.each(data, function (index, content) {

        if (content.majorId === selected) {
            $("#" + select).append("<option value='" + content.majorId + "' selected>" + content.majorName + "</option>")
        } else {
            $("#" + select).append("<option value='" + content.majorId + "'>" + content.majorName + "</option>")
        }
    })
    if (data.length == 0) {
        $("#" + select).append("<option value=''>无数据</option>")
    }
}
</script>



