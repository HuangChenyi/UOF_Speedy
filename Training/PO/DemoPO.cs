using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Training.Data;

namespace Training.PO
{
    internal class DemoPO :Ede.Uof.Utility.Data.BasePersistentObject
    {
   
        internal DataTable GetUserData(string groupId)
        {
           

            string cmdTxt = @"SELECT ACCOUNT ,
                                     NAME 
                            FROM
                                TB_EB_USER 
                            INNER JOIN TB_EB_EMPL_DEP
                                ON TB_EB_USER.USER_GUID = TB_EB_EMPL_DEP.USER_GUID
                            WHERE GROUP_ID = @GROUP_ID
                                ";

            this.m_db.AddParameter("@GROUP_ID", groupId);

            DataTable dt = new DataTable();

            dt.Load(this.m_db.ExecuteReader(cmdTxt));

            return dt;

        }

      
        internal void InsertTaskData(DataRow dr)
        {
            string cmdTxt = @"  INSERT INTO [dbo].[TB_DEMO_TASK]  
(	 [FILE_NAME] , 
	 [TYPE_NAME] , 
	 [EXECUTE_TIME] , 
	 [PARAMS]  
) 
 VALUES 
 (	 @FILE_NAME , 
	 @TYPE_NAME , 
	 @EXECUTE_TIME , 
	 @PARAMS  
)";

            this.m_db.AddParameter("@FILE_NAME", dr["FILE_NAME"]);
            this.m_db.AddParameter("@TYPE_NAME", dr["TYPE_NAME"]);
            this.m_db.AddParameter("@EXECUTE_TIME", Convert.ToDateTime( dr["EXECUTE_TIME"]));
            this.m_db.AddParameter("@PARAMS", dr["PARAMS"]);

            this.m_db.ExecuteNonQuery(cmdTxt);

        }

        internal DataTable GetUserData()
        {
            string cmdTxt = @"SELECT ACCOUNT ,
                                     NAME ,TB_EB_USER.USER_GUID
                            FROM
                                TB_EB_USER 
                            INNER JOIN TB_EB_EMPL_DEP
                                ON TB_EB_USER.USER_GUID = TB_EB_EMPL_DEP.USER_GUID
                
                                ";



            DataTable dt = new DataTable();

            dt.Load(this.m_db.ExecuteReader(cmdTxt));

            return dt;
        }

        internal void InsertWsEndFormData(System.Data.DataRow dr)
        {
            string cmdTxt = @"  INSERT INTO [dbo].[TB_DEMO_WS_FORM]  
                                (	 [ID] , 
	                                 [ITEM_QTY] , 
	                                 [ITEM_PRICE] , 
	                                 [ITEM] , 
	                                 [DOC_NBR] , 
	                                 [FORM_RESULT]  
                                ) 
                                 VALUES 
                                 (	 @ID , 
	                                 @ITEM_QTY , 
	                                 @ITEM_PRICE , 
	                                 @ITEM , 
	                                 @DOC_NBR , 
	                                 @FORM_RESULT  
                                )";

            this.m_db.AddParameter("@ID", dr["ID"]);
            this.m_db.AddParameter("@ITEM_QTY", dr["ITEM_QTY"]);
            this.m_db.AddParameter("@ITEM_PRICE", dr["ITEM_PRICE"]);
            this.m_db.AddParameter("@ITEM", dr["ITEM"]);
            this.m_db.AddParameter("@DOC_NBR", dr["DOC_NBR"]);
            this.m_db.AddParameter("@FORM_RESULT", dr["FORM_RESULT"]);

            this.m_db.ExecuteNonQuery(cmdTxt);

        }

        internal void InsertDDLStartFormData(DemoDataSet.TB_DEMO_DLL_FORMRow dr)
        {
            string cmdTxt = @"  INSERT INTO [dbo].[TB_DEMO_DLL_FORM]  
                                        (	 [ID] , 
	                                         [ITEM_QTY] , 
	                                         [ITEM_PRICE] , 
	                                         [ITEM] , 
	                                         [DOC_NBR] , 
	                                         [SIGN_STATIS] , 
	                                         [REMARK]  
                                        ) 
                                         VALUES 
                                         (	 @ID , 
	                                         @ITEM_QTY , 
	                                         @ITEM_PRICE , 
	                                         @ITEM , 
	                                         @DOC_NBR , 
	                                         @SIGN_STATIS , 
	                                         @REMARK  
                                        )";
           
            this.m_db.AddParameter("@ID", dr.ID);
            this.m_db.AddParameter("@ITEM_QTY", dr.ITEM_QTY);
            this.m_db.AddParameter("@ITEM_PRICE", dr.ITEM_PRICE);
            this.m_db.AddParameter("@ITEM", dr.ITEM);
            this.m_db.AddParameter("@DOC_NBR", dr.DOC_NBR);
            this.m_db.AddParameter("@SIGN_STATIS", dr.SIGN_STATIS);
            this.m_db.AddParameter("@REMARK", dr.REMARK);

            this.m_db.ExecuteNonQuery(cmdTxt);
        }

        internal void UpdateFormStatus(string docNbr, string signStatus)
        {
            string cmdTxt = @"  UPDATE [dbo].[TB_DEMO_DLL_FORM]  
                             SET 
	                             [SIGN_STATIS] = @SIGN_STATIS  

                            WHERE 
	                            [DOC_NBR] = @DOC_NBR";

            this.m_db.AddParameter("@SIGN_STATIS", signStatus);
            this.m_db.AddParameter("@DOC_NBR", docNbr);

            this.m_db.ExecuteNonQuery(cmdTxt);
        }

        internal void UpdateFormResult(string docNbr, string formResult)
        {

            
            string cmdTxt = @"  UPDATE [dbo].[TB_DEMO_DLL_FORM]  
                             SET 
	                             [FORM_RESULT] = @FORM_RESULT  

                            WHERE 
	                            [DOC_NBR] = @DOC_NBR";

            this.m_db.AddParameter("@FORM_RESULT", formResult);
            this.m_db.AddParameter("@DOC_NBR", docNbr);

            this.m_db.ExecuteNonQuery(cmdTxt);
        }

        internal string GetUsingVerionId(string formName)
        {
            string cmdTxt = @"select 
USING_VERSION_ID from TB_WKF_FORM
where FORM_NAME=@FORM_NAME";

            this.m_db.AddParameter("FORM_NAME", formName);
            object obj = this.m_db.ExecuteScalar(cmdTxt);

            if (obj == null)
                return "";
            else
                return obj.ToString();
        }

        internal void InsertSignForm(string aFormNbr, string bFormNbr)
        {
            string cmdTxt = @"INSERT TB_SIGN_FORM
SELECT @aFormNbr,@bFormNbr";

            this.m_db.AddParameter("@aFormNbr", aFormNbr);
            this.m_db.AddParameter("@bFormNbr", bFormNbr);

            this.m_db.ExecuteNonQuery(cmdTxt);
        }

        internal DataTable GetSignForm(string aformNbr)
        {
            string cmdTxt = @"SELECT 
A_FORM_NBR,B_FORM_NBR
FROM
TB_SIGN_FORM
WHERE A_FORM_NBR=@A_FORM_NBR";

            this.m_db.AddParameter("@A_FORM_NBR", aformNbr);

            DataTable dt = new DataTable();

            dt.Load(this.m_db.ExecuteReader(cmdTxt));

            return dt;
        }

        internal void DeleteSignForm(string formNumber)
        {
            string cmdTxt = @"
DELETE TB_SIGN_FORM
WHERE B_FORM_NBR=@B_FORM_NBR";

            this.m_db.AddParameter("@B_FORM_NBR", formNumber);

            this.m_db.ExecuteNonQuery(cmdTxt);
        }
    }
}
