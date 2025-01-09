package com;

public class LoginBean
{
  private String uname;
  private String pass;
  private String username;
  private String role_id;
  private String role_desc;
  private String module;
  private String menu_url;
  private int uid;
  private int role;
  private int module_id;
  private int org_id;
  private boolean status;
  
  public String getModule()
  {
    return this.module;
  }
  
  public int getOrg_id()
  {
    return this.org_id;
  }
  
  public void setOrg_id(int org_id)
  {
    this.org_id = org_id;
  }
  
  public void setModule(String module)
  {
    this.module = module;
  }
  
  public String getMenu_url()
  {
    return this.menu_url;
  }
  
  public void setMenu_url(String mennu_url)
  {
    this.menu_url = mennu_url;
  }
  
  public int getModule_id()
  {
    return this.module_id;
  }
  
  public void setModule_id(int module_id)
  {
    this.module_id = module_id;
  }
  
  public boolean isStatus()
  {
    return this.status;
  }
  
  public void setStatus(boolean status)
  {
    this.status = status;
  }
  
  public int getUid()
  {
    return this.uid;
  }
  
  public void setUid(int uid)
  {
    this.uid = uid;
  }
  
  public int getRole()
  {
    return this.role;
  }
  
  public void setRole(int role)
  {
    this.role = role;
  }
  
  public String getUname()
  {
    return this.uname;
  }
  
  public void setUname(String uname)
  {
    this.uname = uname;
  }
  
  public String getPass()
  {
    return this.pass;
  }
  
  public void setPass(String pass)
  {
    this.pass = pass;
  }
  
  public String getUsername()
  {
    return this.username;
  }
  
  public void setUsername(String username)
  {
    this.username = username;
  }
  
  public String getRole_id()
  {
    return this.role_id;
  }
  
  public void setRole_id(String role_id)
  {
    this.role_id = role_id;
  }
  
  public String getRole_desc()
  {
    return this.role_desc;
  }
  
  public void setRole_desc(String role_desc)
  {
    this.role_desc = role_desc;
  }
}
