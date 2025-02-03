<%@ Page Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" Inherits="WKF_FormManagement_SetupFieldLinkedOption" Title="設定欄位選項值" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" CodeBehind="SetupFieldLinkedOption.aspx.cs" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        Sys.Application.add_load(function () {
            var tree = $find("<%= RadTreeView1.ClientID %>");
            var selectedNode = tree.get_selectedNode()
            if (selectedNode != null) {
                window.setTimeout(function () { selectedNode.scrollIntoView(); }, 500);
            }
            checkNodePostion(selectedNode);
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        function EndRequestHandler(sender, args) {
            //display scroll bar
            window.setTimeout(function () { resizeTree($("#<%=leftX.ClientID%>").val(), $("#<%=leftY.ClientID%>").val()); }, 500);
        }

        function resizeTree(X, Y) {
            var tree = $find("<%=RadTreeView1.ClientID %>");
            tree.get_element().style.width = X + "px";
            $("#<%=leftX.ClientID%>").val(X);
            $("#<%=leftY.ClientID%>").val(Y);
        }

        function EditCategoryNode() {
            var tree = $find("<%= RadTreeView1.ClientID %>");
            var node = tree.get_selectedNode();

            if (node != null && $('#<%=hidNeedEdit.ClientID%>').val() == 'true') {
                node.startEdit();
            }
        }

        function treeSubFlow_Load(sender, eventArgs) {
            EditCategoryNode();
        }

        function Nodedropping(e, args) {


            //目的地節點如果找不到，取消拖拉動作
            if (!args.get_destNode()) {
                args.set_cancel(true);
            }



        }


        function ClientNodeClicked(sender, eventArgs) {
            var node = eventArgs.get_node();
            node.set_selected(true);
            var parentNode = node.parentNode


            checkNodePostion(node);
        }


        function SetToolbarEnable(enable) {

            var oToolbar = $find("<%=RadToolBar1.ClientID %>");
            var itemcreate = oToolbar.findItemByValue("AddItem");
            var itemdel = oToolbar.findItemByValue("delete");
            itemcreate.set_enabled(enable);
            itemdel.set_enabled(enable);

        }

        function checkNodePostion(treeNode) {
            var oToolbar = $find("<%=RadToolBar1.ClientID %>");
            var itemadditem = oToolbar.findItemByValue("AddItem");
            var itemdelete = oToolbar.findItemByValue("DeleteItem");
            var itemdown = oToolbar.findItemByValue("Movedown");
            var itemup = oToolbar.findItemByValue("Moveup");



            if (treeNode != null) {
                var type = treeNode.get_attributes().getAttribute("itemtype");
                if (type == "sub") {
                    itemadditem.set_enabled(false);
                } else {
                    itemadditem.set_enabled(true);
                }

                itemdelete.set_enabled(true);

                itemdown.set_enabled((treeNode.get_nextNode() != null));
                itemup.set_enabled((treeNode.get_previousNode() != null));

                if (type == "default") {
                    itemdelete.set_enabled(false);
                }


            }
            else {
                itemadditem.set_enabled(false);
                itemdelete.set_enabled(false);
                itemdown.set_enabled(false);
                itemup.set_enabled(false);
            }
        }
        function checkNodeName(node, name) {
            for (i = 0; i < node.get_nodes().get_count(); i++) {

                var item = node.get_nodes().getNode(i);
                if (item.get_textElement().innerHTML == name) {

                    return false;
                }
            }
            return true;

        }

        function OnClientNodeEditStartHandler(sender, eventArgs) {
            var node = eventArgs.get_node();
            var textInput = node.get_inputElement();
            textInput.width = "150";
            textInput.maxLength = 40; // Set the MaxLength 
        }

    </script>

    <telerik:RadSplitter ID="MainRadSplitter" runat="server" Width="100%" LiveResize="true" ResizeWithBrowserWindow="true" ResizeWithParentPane="true" Orientation="Horizontal" BorderSize="0">
        <telerik:RadPane ID="TopRadPane" runat="server" Height="35px" Scrolling="None">
            <telerik:RadToolBar ID="RadToolBar1" runat="server" meta:resourcekey="UltraWebToolbar1Resource1" OnButtonClick="RadToolBar1_ButtonClick"
                Width="100%">
                <Items>
                    <telerik:RadToolBarButton runat="server"
                        Text="新增項目"
                        HoveredImageUrl="~/System/icon_images/icon_m19.gif"
                        ImageUrl="~/System/icon_images/icon_m19.gif"
                        Value="AddItem"
                        CheckedImageUrl="~/System/icon_images/icon_m19.gif"
                        meta:resourcekey="TBarButtonResource1">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Value="s1">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server"
                        Text="刪除"
                        HoveredImageUrl="~/System/icon_images/icon_m03.gif"
                        ImageUrl="~/System/icon_images/icon_m03.gif"
                        Value="DeleteItem"
                        CheckedImageUrl="~/System/icon_images/icon_m03.gif"
                        meta:resourcekey="TBarButtonResource2">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Value="s2">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" HoveredImageUrl="~/Common/Images/Icon/icon_m113.gif"
                        ImageUrl="~/Common/Images/Icon/icon_m113.gif" Value="Moveup" CheckedImageUrl="~/Common/Images/Icon/icon_m113.gif"
                        Text="上移" meta:resourcekey="TBarButtonResource3">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Value="s3">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" HoveredImageUrl="~/Common/Images/Icon/icon_m114.gif"
                        ImageUrl="~/Common/Images/Icon/icon_m114.gif" Value="Movedown" CheckedImageUrl="~/Common/Images/Icon/icon_m114.gif"
                        Text="下移" meta:resourcekey="TBarButtonResource4">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Value="s4">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" meta:resourcekey="RadToolBarButtonResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblDragToOrder" runat="server" Text="*也可拖拉項目進行排序" ForeColor="Blue" meta:resourcekey="lblDragToOrderResource1"></asp:Label>
                        </ItemTemplate>
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </telerik:RadPane>
        <telerik:RadPane ID="TreeRadPane" runat="server">
            <asp:UpdatePanel ID="UpdatePanel1"
                runat="server" RenderMode="Inline" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:CustomValidator ID="cvCheckExistSubItem" runat="server" ErrorMessage="所選項目下仍存在子項目，不可刪除" Display="Dynamic" meta:resourcekey="cvCheckExisiSubItemResource1"></asp:CustomValidator>
                    <asp:CustomValidator ID="cvCheckNotSetSubItem" runat="server" Display="Dynamic" meta:resourcekey="cvCheckNotSetSubItemResource1"></asp:CustomValidator>
                    <telerik:RadTreeView ID="RadTreeView1" runat="server"
                        EnableDragAndDrop="true"
                        AllowNodeEditing="true"
                        OnNodeDrop="RadTreeView1_NodeDrop"
                        OnClientNodeDropping="Nodedropping"
                        OnClientNodeClicked="ClientNodeClicked"
                        OnNodeEdit="RadTreeView1_NodeEdit"
                        OnClientNodeEditStart="OnClientNodeEditStartHandler"
                        OnClientLoad="treeSubFlow_Load">
                    </telerik:RadTreeView>
                    <input id="hidNeedEdit" runat="server" type="hidden" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="RadToolBar1"
                        EventName="ButtonClick" />
                </Triggers>
            </asp:UpdatePanel>
        </telerik:RadPane>
    </telerik:RadSplitter>

    <asp:Label ID="lblRepeatName" runat="server" Text="項目名稱不可重複" Visible="false" meta:resourcekey="lblRepeatNameResource1"></asp:Label>
    <asp:Label ID="lblForbidChar" runat="server" Text="{0}為保留字，請勿使用" Visible="false" meta:resourcekey="lblForbidCharResource1"></asp:Label>
    <asp:Label ID="lblEmptyName" runat="server" Text="項目名稱不可空白" Visible="false" meta:resourcekey="lblEmptyNameResource1"></asp:Label>
    <asp:Label ID="lblDefaultOptionName" runat="server" Text="選項內容" Visible="false" meta:resourcekey="lblDefaultOptionNameResource1"></asp:Label>
    <asp:Label ID="lblUsedInConditions" runat="server" Text="此欄位已被設定為表單條件，不允許變更或刪除選項！" Visible="false" meta:resourcekey="lblUsedInConditionsResource1"></asp:Label>
    <asp:Label ID="lblNotSetSubItem" runat="server" Text="以下項目({0})未設定子項目，請重新設定" Visible="false" meta:resourcekey="lblNotSetSubItemResource1"></asp:Label>
    <asp:Label ID="lblHasSubItem" runat="server" Text="項目({0})下已有子項目，無法移至指定位置" Visible="false" meta:resourcekey="lblHasSubItemResource1"></asp:Label>
    <asp:Label ID="lblNoItem" runat="server" Text="請設定選項內容" Visible="false" meta:resourcekey="lblNoItemResource1"></asp:Label>
    <asp:HiddenField ID="hidden_oldNodeText" runat="server" />
    <asp:HiddenField ID="leftX" runat="server" />
    <asp:HiddenField ID="leftY" runat="server" />
</asp:Content>
