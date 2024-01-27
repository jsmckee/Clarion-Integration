using RGiesecke.DllExport;
using System;
using System.Linq;
using System.Runtime.InteropServices;

namespace DotNetLibrary
{
	/// <summary>
	/// Class to export our static methods to use in Clarion.
	/// </summary>
	public class DotNetExport
	{
		/// <summary>
		/// Delegate definition that sends a single string variable.
		/// </summary>
		/// <param name="ReturnValue"></param>
		public delegate void StringCallbackProcedure([MarshalAs(UnmanagedType.BStr)] ref String ReturnValue);

		[DllExport("DotNetProcedure", CallingConvention = CallingConvention.StdCall)]
		public static void DotNetProcedure(StringCallbackProcedure onsuccess, StringCallbackProcedure onerror, [MarshalAs(UnmanagedType.BStr)] string id, [MarshalAs(UnmanagedType.BStr)] string data)
		{
			try
			{
				var result = new DotNetClass().DoSomething(id, data);
				if (onsuccess != null)
				{
					onsuccess(ref result);
				}
			}
			catch (Exception ex)
			{
				if (onerror != null)
				{
					var errormessage = ex.Message;
					onerror(ref errormessage);
				}
			}
		}
	}
}
