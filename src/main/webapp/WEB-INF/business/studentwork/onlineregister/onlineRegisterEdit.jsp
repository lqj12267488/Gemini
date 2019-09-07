<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="classValue" type="hidden" value="${classId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div>
                <div class="form-row">
                    <div class="col-md-6 tar">
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                 姓名
                            </div>
                            <div class="col-md-8">
                                <input type="text" value="${data.name}" disabled/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                 性别
                            </div>
                            <div class="col-md-8">
                                <input ype="text" value="${data.sex}" disabled/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4  tar" id="idcardAlert">
                                 身份证号
                            </div>
                            <div class="col-md-8">
                                <input type="text"  value="${data.idcard}" disabled/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">出生日期</div>
                            <div class="col-md-8">
                                <input type="text" value="${data.birthday}" disabled/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div style="float: right;width: 354px;height: 150px;">
                            <div style="width: 218px;height: 150px;margin-top: -4px;">
                                <img id="photo"
                                     style="border: 1px dashed #ffffff;width: 136px;height: 172px;margin-top: 2px;margin-left: 58px"
                                     src="<%=request.getContextPath()%>/upload/${data.id}/${data.img}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                         民族
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.nation}" disabled/>
                    </div>
                    <div class="col-md-2 tar">
                         语言
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.language}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        父亲电话
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.fatherTel}" disabled/>
                    </div>
                    <div class="col-md-2 tar">
                        母亲电话
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.motherTel}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        考生类别
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.examTypeShow}" disabled/>
                    </div>
                    <div class="col-md-2 tar">
                        生源
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.province}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        毕业学校
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.graduatedSchool}" disabled/>
                    </div>
                    <div class="col-md-2 tar">
                        毕业时间
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.graduationDate}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        准考证号
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.examinationCardNumber}" disabled/>
                    </div>
                    <div class="col-md-2 tar">
                        报名起点
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.registerOriginShow}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        考试成绩
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.examScore}" disabled/>
                    </div>
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-4">
                        <input type="text" value="${data.remark}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        身份证附件
                    </div>
                    <div class="col-md-4">
                        <a href="#" onclick="showFiles('${data.idcardImg}')">查看附件</a>
                    </div>
                    <div class="col-md-2 tar">
                        准考证附件
                    </div>
                    <div class="col-md-4">
                        <a href="#" onclick="showFiles('${data.examinationImg}')">查看附件</a>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        成绩单附件
                    </div>
                    <div class="col-md-4">
                        <a href="#" onclick="showFiles('${data.scoreImg}')">查看附件</a>
                    </div>
                    <div class="col-md-2 tar">
                        户口本附件
                    </div>
                    <div class="col-md-4">
                        <a href="#" onclick="showFiles('${data.hukouImg}')">查看附件</a>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        毕业证附件
                    </div>
                    <div class="col-md-4">
                        <a href="#" onclick="showFiles('${data.graduatedImg}')">查看附件</a>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        审核意见
                    </div>
                    <div class="col-md-10">
                        <textarea rows="3" id="s_auditmind"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <c:if test='${data.auditFlag=="0"}'>
            <button type="button" class="btn btn-success btn-clean" onclick="audit(1)">通过</button>
            <button type="button" class="btn btn-success btn-clean" onclick="audit(2)">不通过</button>
            </c:if>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function showFiles(files){
        $("#dialogFile").load("<%=request.getContextPath()%>/onlineregister/getOnlineRegisterPreview?id=${data.id}&files=" + files);
        $("#dialogFile").modal("show");
    }

    function audit(flag) {
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/onlineregister/audit", {
            ids: "${data.id}",
            flag: flag,
            mind: $("#s_auditmind").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }
        })
    }
</script>