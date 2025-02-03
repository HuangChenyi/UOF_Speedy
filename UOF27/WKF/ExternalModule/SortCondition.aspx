<%@ Page Title="調整條件順序" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="SortCondition.aspx.cs" Inherits="Ede.Uof.Web.WKF.ExternalModule.SortCondition" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function ClientNodeClicked(sender, args) {
            var node = args.get_node();
            checkNodePostion(node);
        }

        Sys.Application.add_load(function () {
            window.setTimeout(function () { resizeClassTree($("#<%=leftX.ClientID%>").val(), $("#<%=leftY.ClientID%>").val()); }, 200);
            var tree = $find("<%= RadTreeViewCondition.ClientID %>");
            var selectedNode = tree.get_selectedNode();
            if (selectedNode != null) {
                window.setTimeout(function () { selectedNode.scrollIntoView(); }, 500);
            }
            checkNodePostion(selectedNode);
        });


        function resizeClassTree(X, Y) {
            var tree = $find("<%=RadTreeViewCondition.ClientID %>");
            tree.get_element().style.height = Y - 35 + "px";
            tree.get_element().style.width = X + "px";

            $("#<%=leftX.ClientID%>").val(X);
            $("#<%=leftY.ClientID%>").val(Y);
        }

        function RadToolBar1_Class_ButtonClicking(sender, args) {
            //Add code to handle your event here.
            var tree = $find('<%=RadTreeViewCondition.ClientID %>');
            var formVesrionId = $("#<%=hidFormVersionId.ClientID %>").val();
            var Key = args.get_item().get_value()
            if (Key == "MoveUp") {
                var sourceNode = tree.get_selectedNode();
                var effectNode = sourceNode.get_previousNode();
                $("#<%=hidsourceNode.ClientID %>").val(sourceNode.get_value());
                $("#<%=hideffectNode.ClientID %>").val(effectNode.get_value());
            }
            else if (Key == "MoveDown") {

                var sourceNode = tree.get_selectedNode();
                var effectNode = sourceNode.get_nextNode();

                $("#<%=hidsourceNode.ClientID %>").val(sourceNode.get_value());
                $("#<%=hideffectNode.ClientID %>").val(effectNode.get_value());

            }
        }

        function checkUpButton(enable) {
            var oToolbar = $find("<%=RadToolBar1.ClientID %>");
            var itemup = oToolbar.findItemByValue("MoveUp");
            itemup.set_enabled(enable);
        }
        function checkDownButton(enable) {
            var oToolbar = $find("<%=RadToolBar1.ClientID %>");
            var itemdown = oToolbar.findItemByValue("MoveDown");
            itemdown.set_enabled(enable);
        }


        function FolderTreeClientNodeDragStart(sender, args) {
            var node = args.get_node();
            //when tree editable and start drag, disable node edit
            if (sender.get_allowNodeEditing()) {
                node.set_allowEdit(false);
            }
        }

        function FolderTreeClientNodeDropping(sender, args) {

            var nSource = args.get_sourceNode();
            var nDest = args.get_destNode();

            if (nDest) {
                var tree = nDest.get_treeView();
                var level = nDest.get_level();
                var position = args.get_dropPosition();



                var tree = $find("<%= RadTreeViewCondition.ClientID %>");
                tree.trackChanges();
                switch (position) {
                    case "over":

                        var sourceIndex = nSource.get_index();
                        insertIndex = nDest.get_index();

                        break;
                    case "above":
                        var insertIndex
                        var sourceIndex = nSource.get_index();
                        insertIndex = nDest.get_index();
                        if (sourceIndex < insertIndex)
                            insertIndex -= 1;


                        nSource.get_parent().get_nodes().remove(nSource);
                        nDest.get_parent().get_nodes().insert(insertIndex, nSource);
                        break;
                    case "below":
                        var insertIndex
                        var sourceIndex = nSource.get_index();
                        insertIndex = nDest.get_index();

                        if (sourceIndex > insertIndex)
                            insertIndex += 1;

                        nSource.get_parent().get_nodes().remove(nSource);
                        nDest.get_parent().get_nodes().insert(insertIndex, nSource);
                        break;
                }
                tree.commitChanges();
                nDest.set_expanded(true);

            }

        }

        function checkNodePostion(treeNode) {
            if (treeNode != null) {
                checkUpButton((treeNode.get_previousNode() != null));
                checkDownButton((treeNode.get_nextNode() != null));

                $("#<%=hidNodePrevious.ClientID %>").val((treeNode.get_previousNode() != null));
                $("#<%=hidNodeNext.ClientID %>").val((treeNode.get_nextNode() != null));
            }
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
        <ContentTemplate>
            <telerik:RadToolBar ID="RadToolBar1" runat="server" Width="100%" OnButtonClick="RadToolBar1_ButtonClick" OnClientButtonClicking="RadToolBar1_Class_ButtonClicking">
                <Items>
                    <telerik:RadToolBarButton runat="server" Value="MoveUp" Text="上移"
                        HoveredImageUrl="~/Common/Images/Icon/icon_m113.gif"
                        ImageUrl="~/Common/Images/Icon/icon_m113.gif"
                        DisabledImageUrl="~/Common/Images/Icon/icon_m113.gif"
                        ClickedImageUrl="~/Common/Images/Icon/icon_m113.gif" meta:resourcekey="RadBtnMoveUpResource1">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Value="s1">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" Value="MoveDown" Text="下移"
                        HoveredImageUrl="~/Common/Images/Icon/icon_m114.gif"
                        ImageUrl="~/Common/Images/Icon/icon_m114.gif"
                        DisabledImageUrl="~/Common/Images/Icon/icon_m114.gif"
                        ClickedImageUrl="~/Common/Images/Icon/icon_m114.gif" meta:resourcekey="RadBtnMoveDownResource1">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Value="s2">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton>
                        <ItemTemplate>
                            <asp:Label runat="server" Text="*拖拉名稱也可排序" ForeColor="Blue" meta:resourcekey="lblTipResource1"></asp:Label>
                        </ItemTemplate>
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
            <telerik:RadTreeView ID="RadTreeViewCondition" runat="server" AllowNodeEditing="false" EnableDragAndDrop="True" EnableDragAndDropBetweenNodes="True"
                OnClientNodeClicked="ClientNodeClicked"
                OnNodeClick="RadTreeViewCondition_NodeClick"
                OnClientNodeDragStart="FolderTreeClientNodeDragStart"
                OnClientNodeDropping="FolderTreeClientNodeDropping" OnNodeDrop="RadTreeViewCondition_NodeDrop"
                EnableNodeTextHtmlEncoding="true"
                Height="100%" Width="100%">
            </telerik:RadTreeView>

            <asp:HiddenField ID="hidFormVersionId" runat="server" />
            <asp:HiddenField ID="hidsourceNode" runat="server" />
            <asp:HiddenField ID="hideffectNode" runat="server" />
            <asp:HiddenField ID="hidNodePrevious" runat="server" />
            <asp:HiddenField ID="hidNodeNext" runat="server" />
            <asp:HiddenField ID="leftX" runat="server" />
            <asp:HiddenField ID="leftY" runat="server" />

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

