﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

namespace Starotel.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index() {
            return Redirect("~/Default.aspx");
        }
    }
}