<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
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
                                培养方案：
                            </div>
                            <div class="col-md-2">
                                <input id="tname"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSearch"
                                        onchange="changeSearchMajor()"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业
                            </div>
                            <div class="col-md-2">
                                <select id="majorCodeSearch"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
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
<script>
    var table;
    var index=0;
    var roleEmpDeptRelation='${roleEmpDeptRelation}';
    var uid='${uid}';
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsIdSearch', '${tt.departmentsId}');
        });
        $("#majorCodeSearch").append("<option value='' selected>请选择</option>")
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                    "url": '<%=request.getContextPath()%>/major/talentTrainList',
            },
            "destroy": true,
            "columns": [
                {"data":"id","visible":false},
                {"data": "createTime", "visible": false},
                {
                    className: "td-no",
                    'title':'序号',
                    "render":function (data, type, row, meta) {
                        var no = meta.settings._iDisplayStart + meta.row + 1;
                        return no;
                    }
                },
                {"data": "trainPlan", "title": "培养方案"},
                {
                    "data": "yearType",
                    "title": "版本",
                    "render": function (data,  type, row) {
                        return row.yearType+'版';
                    }
                },
                {"data": "uploadTime","title": "上传时间"},
                {"data": "suitSchool","title": "适用学院"},
                {"data": "majorIdShow", "title": "专业"},
                {"data": "majorCode", "title": "专业代码"},
                {"data": "trainingLevel", "title": "培养层次"},
                {"data": "schoolSystem", "title": "学制"},
                {"data": "trainMode", "title": "培养模式"},
                {"data": "actionGrade", "title": "执行年级"},
                {
                    "title": "人才培养方案上传情况",
                    "render": function (data,type, row) {
                        var temp=(row.teachFile11!='')&&(row.teachFile11!=null)&&(row.teachFile11!=undefined);
                        var temp1=(row.practiceFile!='')&&(row.practiceFile!=null)&&(row.practiceFile!=undefined);
                        var temp2=(row.distributeFile!='')&&(row.distributeFile!=null)&&(row.distributeFile!=undefined);
                        if(temp||temp1||temp2){
                            return '已上传';
                        }else{
                            return '未上传';
                        }
                    }
                },
                {
                    "data": "teachFile11",
                    "title": "附件1：教学活动时间安排表",
                    "render": function (data, type, row) {
                        return checkImgType(row.teachFile11, row.teachFileType, row.id, "teachFile11");
                    }
                },
                {
                    "data": "distributeFile",
                    "title": "附件2：课程设置、教学进度计划及课时分配表",
                    "render": function (data, type, row) {
                        return checkImgType(row.distributeFile, row.distributeFileType, row.id, "distributeFile");
                    }
                },
                {
                    "data": "practiceFile",
                    "title": "附件3：实践教学活动安排表",
                    "render": function (data, type, row) {
                        
                        return checkImgType(row.practiceFile, row.practiceFileType, row.id, "practiceFile");
                    }

                },
                {"data": "requestFlag", "title": "审核结果"},
                {
                    "data": "remark",
                    "title": "审核意见",
                    "render": function (data, type, row) {
                        if(row.requestFlag=='审批通过'){
                            return row.remark;
                        }else{
                            return "";
                        }
                    }
                },
                {
                    "data":"remark",
                    "title":"驳回原因",
                    "render":function(data, type, row){
                        if(row.requestFlag=='审批通过'){
                            return "";
                        }else{
                            return row.remark;
                        }
                    }
                },
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        if (row.requestFlag =="未提交" || row.requestFlag == "审批驳回" || row.requestFlag =="审批未通过") {
                            //判断是否有修改权限
                            if(uid==row.creator) {
                                return '<span class="icon-edit" title="修改" onclick=update("' + row.id + '","' + row.requestFlag + '")/>&ensp;&ensp;' +
                                    '<span class="icon-trash" title="删除" onclick=del("' + row.id + '","' + row.planName + '")/>&ensp;&ensp;' +
                                    '<span class="icon-exchange" title="关联教学计划" onclick=relation("' + row.id + '","' + row.planName + '")/>&ensp;&ensp;' +
                                    '<span class="icon-upload-alt" title="提交" onclick=submit("' + row.id + '","' + row.planName + '","' + row.requestFlag + '")/>&ensp;&ensp;'
                            }else{
                                return '<span class="icon-exchange" title="关联教学计划" onclick=relation("' + row.id + '","' + row.planName + '")/>';
                            }
                        }else if(row.requestFlag =="审批中") {

                            //判断登录人是否有审核驳回权限
                            if(roleEmpDeptRelation==''|| roleEmpDeptRelation=='null'){
                                return '<span class="icon-search" title="查看关联教学计划" onclick=relation("' + row.id +'","'+ row.planName +'")/>&ensp;&ensp;';
                            }else{
                                return  '<span class="icon-file-text-alt" title="审核" onclick=review("' +  row.id  + '","' +  row.requestFlag +'")/>&ensp;&ensp;' +
                                    '<span class="icon-ban-circle" title="驳回" onclick=toAgainst("' +  row.id  + '","' +  row.requestFlag +'")/>&ensp;&ensp;'+
                                    '<span class="icon-search" title="查看关联教学计划" onclick=relation("' + row.id +'","'+ row.planName +'")/>&ensp;&ensp;';
                            }
                        }else{
                            return  '';
                        }
                    }
                }
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });

        /*table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;//该条数据的id
            /!*if (this.id == "download" || this.id == "download1"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + id + '&businessType=TEST&tableName=T_JW_TALENTTRAIN');
                $('#dialogFile').modal('show');
            }*!/
            if (this.id == "download" || this.id == "download1"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUploadTalentTrain?Id=' + id + '&businessType=TEST');
                $('#dialogFile').modal('show');
            }
        });*/
    })

    //弹出驳回信息框
    function toAgainst(id,requestFlag) {
        $("#dialog").load("<%=request.getContextPath()%>/major/toAgainst?id=" + id);
        $("#dialog").modal("show");
    }

    function changeSearchMajor() {
        var deptId = $("#departmentsIdSearch").val();
        $.get("<%=request.getContextPath()%>/course/getMajorByDepId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSearch');
        });
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/major/editTalent");
        $("#dialog").modal("show");
    }

    /**
     * 修改培养方案
     * @param id
     * @param requestFlag
     */
    function update(id,requestFlag) {
        // if(requestFlag !="未提交" && requestFlag != "审批未通过"){
        //     swal({
        //         title: "此方案以提交审核，不可修改。",
        //         type: "info"
        //     });
        // }else {
            $("#dialog").load("<%=request.getContextPath()%>/major/editTalent?id=" + id);
            $("#dialog").modal("show");
        // }
    }

    /**
     * 审核培养方案
     */
    function  review(id,requestFlag) {
        $("#dialog").load("<%=request.getContextPath()%>/major/talentProcess?id=" + id);
        $("#dialog").modal("show");
    }
    function del(id,planName) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/major/delTalent", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();

            });

        });
    }

    function sub(id,requestFlag) {
        if(requestFlag=="未提交" || requestFlag=="审批未通过") {
            $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_TALENTTRAIN');
            $('#dialogFile').modal('show');
        }else {
            swal({
                title: "此方案以提交审核，不可上传附件。",
                type: "info"
            });
        }
    }

    function submit(id,planName,requestFlag) {
        if(requestFlag=="未提交" || requestFlag=="审批未通过") {
            swal({
                title: "您确定要提交本条信息?",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                $.post("<%=request.getContextPath()%>/major/submitTalent", {
                    id: id
                }, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $('#table').DataTable().ajax.reload();

                });

            });
        }else {
            swal({
                title: "此方案已提交，不可重复提交！",
                type: "info"
            });
        }
    }

    function relation(id,planName) {
        $("#right").load("<%=request.getContextPath()%>/major/relateCoursePlanToArrayClass",{
            id:id,
            trainName:planName
        });
    }

    function search() {
        var planName = $("#tname").val();
        planName=encodeURI(encodeURI(planName));
        var departmentsId = $("#departmentsIdSearch").val();
        var majorid = $("#majorCodeSearch").val();
        table.ajax.url("<%=request.getContextPath()%>/major/talentTrainList?planName="+planName+"&departmentsId="+
            departmentsId+"&majorId="+majorid).load();
    }

    function searchclear() {
        $("#tname").val("");
        $("#departmentsIdSearch").val("");
        $("#majorCodeSearch").val("");
        search();
    }

    /**
     * 判断图标类型 (row.practiceFile, row.practiceFileType, row.id, "practiceFile")
     */
    function checkImgType(teachFileId, fileType, talentTrainId, appendixType){
        if(teachFileId==''||teachFileId==null||teachFileId==undefined){
            return '未上传';
        }else{
            var imgName='';
            if (fileType=='zip'||fileType=='rar') {
                imgName='zip';
            }else if(fileType=='xlsx'||fileType=='xls'){
                imgName='xls';
            }else if(fileType=='docx'||fileType=='doc'){
                imgName='doc';
            }else if(fileType=='pdf'){
                imgName='pdf';
            }else if(fileType=='txt'){
                imgName='txt';
            }else if(fileType=='pptx'||fileType=='ppt'){
                imgName='ppt';
            }else if(fileType=='jpg'||fileType=='gif'||fileType=='png'){
                imgName='jpg';
            }else{
                imgName='未知';
            }
            if(imgName!='未知'){
                return '&ensp;&ensp;<a href="javascript:void(0)" onclick=appendixType("'+teachFileId+'","'+talentTrainId+'","'+appendixType+'")><img title="上传文件类型：'+fileType+'" style="cursor: pointer;" src="/userImg/'+imgName+'.png"/></a>';
            }else{
                return '&ensp;&ensp;<a href="javascript:void(0)" onclick=appendixType("'+teachFileId+'","'+talentTrainId+'","'+appendixType+'")>' +
                    '<span class="icon-cloud-download" title="未知类型附件"></span></a>';
            }
        }
    }

    /**
     * 附件类型
     * @param appendixType
     */
    function appendixType(fileId, talentTrainId, appendixType) {
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUploadTalentTrain?id=' + fileId + "&appendixType="+appendixType+'&businessType=TEST&'+"talentTrainId="+talentTrainId);
        $('#dialogFile').modal('show');

    }
</script>