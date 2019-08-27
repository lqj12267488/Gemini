<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog" style="width: 60%;height: 80%;" >
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="teacherId" hidden value="${teacherTraining.teacherId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="teacherNameSel" type="text" value="${teacherTraining.teacherNameShow}"/>
                        <input id="perId" type="hidden" value="${teacherTraining.teacherName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>培训级别
                    </div>
                    <div class="col-md-9">
                        <select id="trainingLevelSel" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>培训内容
                    </div>
                    <div class="col-md-9">
                        <input id="trainingContentSel" type="text" value="${teacherTraining.trainingContent}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>培训日期
                    </div>
                    <div class="col-md-9">
                        <input id="trainingDate" value="${teacherTraining.trainingDate}"   type="date"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>培训天数
                    </div>
                    <div class="col-md-9">
                        <input id="trainingDay"  value="${teacherTraining.trainingDay}" type="number"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>培训地点
                    </div>
                    <div class="col-md-9">
                        <input id="trainingPlace" value="${teacherTraining.trainingPlace}" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>培训结论
                    </div>
                    <div class="col-md-9">
                        <select id="trainingConclusion" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#teacherNameSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherNameSel").val(ui.item.label);
                    $("#teacherNameSel").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXJB", function (data) {
            addOption(data, 'trainingLevelSel','${teacherTraining.trainingLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXJL", function (data) {
            addOption(data, 'trainingConclusion','${teacherTraining.trainingConclusion}');
        });
        var id = $("#teacherId").val();
        if (id != '') {
            $("#majorSub").attr("disabled", "disabled");
            $("#departmentSub").attr("disabled", "disabled");
        }});
    $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
        addOption(data, 'departmentSub', '${array.departmentsId}');
    });
    $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " major_id",
            text: " major_name ",
            tableName: "t_xg_major"
        },
        function (data) {
            var majorCodeLevel='${array.major}';
            var majorCode = majorCodeLevel.split(",")[0];
            addOption(data, "majorSub",majorCode);
        });

    $("#departmentSub").change(function() {
        if($("#departmentSub").val()!=""){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " distinct id ",
                    text: " name ",
                    tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL as id ," +
                    " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC') as name " +
                    "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+$("#departmentSub").val()+"'  ) ",
                    where: " ",
                    orderby: " "
                },
                function (data1) {
                    addOption(data1, "majorSub", '${array.major}');
                })
        }
    });
    function save() {
        var teacherId=$("#teacherId").val();
        var teacherName = $("#teacherNameSel").val();
        var trainingLevel = $("#trainingLevelSel").val();
        var trainingContent = $("#trainingContentSel").val();
        var trainingDate = $("#trainingDate").val();
        var trainingDay = $("#trainingDay").val();
        var trainingPlace = $("#trainingPlace").val();
        var trainingConclusion = $("#trainingConclusion").val();
        if($("#perId").val()=="" || $("#perId").val() == undefined || $("#perId").val() == null){
            swal({
                title: "请填写教师姓名！",
                type: "info"
            });
            return;
        }
        if(trainingLevel=="" || trainingLevel == undefined || trainingLevel == null){
            swal({
                title: "请选择培训级别！",
                type: "info"
            });
            return;
        }
        if(trainingContent=="" || trainingContent == undefined || trainingContent == null){
            swal({
                title: "请填写培训内容！",
                type: "info"
            });
            return;
        }
        if(trainingDate=="" || trainingDate == undefined || trainingDate == null){
            swal({
                title: "请填写培训日期！",
                type: "info"
            });
            return;
        }
        if(trainingDay=="" || trainingDay == undefined || trainingDay == null){
            swal({
                title: "请填写培训天数！",
                type: "info"
            });
            return;
        }
        if(trainingPlace=="" || trainingPlace == undefined || trainingPlace == null){
            swal({
                title: "请填写培训地点！",
                type: "info"
            });
            return;
        }
        if(trainingConclusion=="" || trainingConclusion == undefined || trainingConclusion == null){
            swal({
                title: "请填写培训结论！",
                type: "info"
            });
            return;
        }
        if($("#teacherNameSel").attr("keycode")=="" || $("#teacherNameSel").attr("keycode") ==null){
            $("#teacherNameSel").attr("keycode",$("#perId").val())
        }
        $.post("<%=request.getContextPath()%>/teacherTraining/save", {
            teacherId: teacherId,
            teacherName:$("#teacherNameSel").attr("keycode"),
            trainingLevel:trainingLevel,
            trainingContent:trainingContent,
            trainingDate:trainingDate,
            trainingDay:trainingDay,
            trainingPlace:trainingPlace,
            trainingConclusion:trainingConclusion,
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#toResultTeacherTable').DataTable().ajax.reload();
        })

    }

</script>

