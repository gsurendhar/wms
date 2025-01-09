package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class roleDao
{
  Connection connection = null;
  PreparedStatement ptmt = null;
  ResultSet rs = null;
  Statement stmt = null;
  String query = "";
  
  /* Error */
  public java.util.List<roleBean> viewAllroles(int oid)
  {
	  return null;
    // Byte code:
    //   0: ldc 40
    //   2: astore_2
    //   3: new 42	java/util/ArrayList
    //   6: dup
    //   7: invokespecial 44	java/util/ArrayList:<init>	()V
    //   10: astore_3
    //   11: aconst_null
    //   12: astore 4
    //   14: aload_0
    //   15: invokestatic 45	com/ConnectionProvider:getCon	()Ljava/sql/Connection;
    //   18: putfield 20	com/roleDao:connection	Ljava/sql/Connection;
    //   21: aload_0
    //   22: aload_0
    //   23: getfield 20	com/roleDao:connection	Ljava/sql/Connection;
    //   26: aload_2
    //   27: invokeinterface 51 2 0
    //   32: putfield 22	com/roleDao:ptmt	Ljava/sql/PreparedStatement;
    //   35: aload_0
    //   36: getfield 22	com/roleDao:ptmt	Ljava/sql/PreparedStatement;
    //   39: iconst_1
    //   40: iload_1
    //   41: invokeinterface 57 3 0
    //   46: aload_0
    //   47: aload_0
    //   48: getfield 22	com/roleDao:ptmt	Ljava/sql/PreparedStatement;
    //   51: invokeinterface 63 1 0
    //   56: putfield 24	com/roleDao:rs	Ljava/sql/ResultSet;
    //   59: goto +85 -> 144
    //   62: new 67	com/roleBean
    //   65: dup
    //   66: invokespecial 69	com/roleBean:<init>	()V
    //   69: astore 4
    //   71: aload 4
    //   73: aload_0
    //   74: getfield 24	com/roleDao:rs	Ljava/sql/ResultSet;
    //   77: ldc 70
    //   79: invokeinterface 72 2 0
    //   84: invokevirtual 78	com/roleBean:setId	(Ljava/lang/String;)V
    //   87: aload 4
    //   89: aload_0
    //   90: getfield 24	com/roleDao:rs	Ljava/sql/ResultSet;
    //   93: ldc 82
    //   95: invokeinterface 72 2 0
    //   100: invokevirtual 84	com/roleBean:setDesc	(Ljava/lang/String;)V
    //   103: aload 4
    //   105: aload_0
    //   106: getfield 24	com/roleDao:rs	Ljava/sql/ResultSet;
    //   109: ldc 87
    //   111: invokeinterface 72 2 0
    //   116: invokevirtual 89	com/roleBean:setOid	(Ljava/lang/String;)V
    //   119: aload 4
    //   121: aload_0
    //   122: getfield 24	com/roleDao:rs	Ljava/sql/ResultSet;
    //   125: ldc 92
    //   127: invokeinterface 72 2 0
    //   132: invokevirtual 94	com/roleBean:setActive	(Ljava/lang/String;)V
    //   135: aload_3
    //   136: aload 4
    //   138: invokeinterface 97 2 0
    //   143: pop
    //   144: aload_0
    //   145: getfield 24	com/roleDao:rs	Ljava/sql/ResultSet;
    //   148: invokeinterface 103 1 0
    //   153: ifne -91 -> 62
    //   156: aload_0
    //   157: getfield 24	com/roleDao:rs	Ljava/sql/ResultSet;
    //   160: invokeinterface 107 1 0
    //   165: goto +70 -> 235
    //   168: astore 5
    //   170: aload 5
    //   172: invokevirtual 110	java/sql/SQLException:printStackTrace	()V
    //   175: aload_0
    //   176: getfield 26	com/roleDao:stmt	Ljava/sql/Statement;
    //   179: ifnull +82 -> 261
    //   182: aload_0
    //   183: getfield 26	com/roleDao:stmt	Ljava/sql/Statement;
    //   186: invokeinterface 115 1 0
    //   191: goto +70 -> 261
    //   194: astore 7
    //   196: aload 7
    //   198: invokevirtual 110	java/sql/SQLException:printStackTrace	()V
    //   201: goto +60 -> 261
    //   204: astore 6
    //   206: aload_0
    //   207: getfield 26	com/roleDao:stmt	Ljava/sql/Statement;
    //   210: ifnull +22 -> 232
    //   213: aload_0
    //   214: getfield 26	com/roleDao:stmt	Ljava/sql/Statement;
    //   217: invokeinterface 115 1 0
    //   222: goto +10 -> 232
    //   225: astore 7
    //   227: aload 7
    //   229: invokevirtual 110	java/sql/SQLException:printStackTrace	()V
    //   232: aload 6
    //   234: athrow
    //   235: aload_0
    //   236: getfield 26	com/roleDao:stmt	Ljava/sql/Statement;
    //   239: ifnull +22 -> 261
    //   242: aload_0
    //   243: getfield 26	com/roleDao:stmt	Ljava/sql/Statement;
    //   246: invokeinterface 115 1 0
    //   251: goto +10 -> 261
    //   254: astore 7
    //   256: aload 7
    //   258: invokevirtual 110	java/sql/SQLException:printStackTrace	()V
    //   261: aload_3
    //   262: areturn
    // Line number table:
    //   Java source line #28	-> byte code offset #0
    //   Java source line #29	-> byte code offset #3
    //   Java source line #30	-> byte code offset #11
    //   Java source line #32	-> byte code offset #14
    //   Java source line #33	-> byte code offset #21
    //   Java source line #34	-> byte code offset #35
    //   Java source line #36	-> byte code offset #46
    //   Java source line #37	-> byte code offset #59
    //   Java source line #38	-> byte code offset #62
    //   Java source line #39	-> byte code offset #71
    //   Java source line #40	-> byte code offset #87
    //   Java source line #41	-> byte code offset #103
    //   Java source line #42	-> byte code offset #119
    //   Java source line #43	-> byte code offset #135
    //   Java source line #37	-> byte code offset #144
    //   Java source line #45	-> byte code offset #156
    //   Java source line #47	-> byte code offset #165
    //   Java source line #51	-> byte code offset #175
    //   Java source line #52	-> byte code offset #182
    //   Java source line #53	-> byte code offset #191
    //   Java source line #54	-> byte code offset #196
    //   Java source line #49	-> byte code offset #204
    //   Java source line #51	-> byte code offset #206
    //   Java source line #52	-> byte code offset #213
    //   Java source line #53	-> byte code offset #222
    //   Java source line #54	-> byte code offset #227
    //   Java source line #56	-> byte code offset #232
    //   Java source line #51	-> byte code offset #235
    //   Java source line #52	-> byte code offset #242
    //   Java source line #53	-> byte code offset #251
    //   Java source line #54	-> byte code offset #256
    //   Java source line #57	-> byte code offset #261
    // Local variable table:
    //   start	length	slot	name	signature
    //   0	263	0	this	roleDao
    //   0	263	1	oid	int
    //   2	25	2	query	String
    //   10	252	3	list	java.util.List<roleBean>
    //   12	125	4	role	roleBean
    //   168	3	5	e	java.sql.SQLException
    //   204	29	6	localObject	Object
    //   194	3	7	e	java.sql.SQLException
    //   225	3	7	e	java.sql.SQLException
    //   254	3	7	e	java.sql.SQLException
    // Exception table:
    //   from	to	target	type
    //   14	165	168	java/sql/SQLException
    //   175	191	194	java/sql/SQLException
    //   14	175	204	finally
    //   206	222	225	java/sql/SQLException
    //   235	251	254	java/sql/SQLException
  }
}
