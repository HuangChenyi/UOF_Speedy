﻿using Ede.Uof.WKF.ExternalUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Training.UCO;

namespace Training.Trigger.SignForm
{
    public class EndFormTrigger : Ede.Uof.WKF.ExternalUtility.ICallbackTriggerPlugin
    {
        public void Finally()
        {
           // throw new NotImplementedException();
        }

        public string GetFormResult(ApplyTask applyTask)
        {

            if(applyTask.FormResult == Ede.Uof.WKF.Engine.ApplyResult.Adopt)
            {
                DemoUCO uco = new DemoUCO();
                uco.DeleteSignForm(applyTask.FormNumber);
            }

            return "";
            //throw new NotImplementedException();
        }

        public void OnError(Exception errorException)
        {
           // throw new NotImplementedException();
        }
    }
}
