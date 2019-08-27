/**
 * Created by Administrator on 2017/8/1.
 */
function qtip_td(data, type, row, meta,q_num,grid) {
    if(data == null)
        data = "";
    var render_td = data;
    if(type === 'display') {
        if (data.length > q_num+1) {
            grid.qtip({
                content: {
                    text: $(data).val()
                },
                style: {
                    classes: 'ui-tooltip-blue ui-tooltip-shadow'
                }
            });
            //"<a  title='"+data +"'>"+data.substring(0, 7) + "..."+"</a>";
            render_td = "<a  title='"+data +"'>"+data.substring(0, q_num) + "..."+"</a>";
            qtip_num = 7;
            return render_td;
        }else {
            render_td = data;
            return render_td;
        }
    }else{
        render_td = data;
        return render_td;
    }
}




