package com;

public class orgBean
{
  private String name;
  private String address1;
  private String address2;
  private String city;
  private String email;
  private int oid;
  private int dstateid;
  private double Tmin;
  private double Tmax;
  private double Wmax;
  private double Hrain;
  private double Pmin;
  private double Pmax;
  
  public double getPmin()
  {
    return this.Pmin;
  }
  
  public void setPmin(double pmin)
  {
    this.Pmin = pmin;
  }
  
  public double getPmax()
  {
    return this.Pmax;
  }
  
  public void setPmax(double pmax)
  {
    this.Pmax = pmax;
  }
  
  public double getTmin()
  {
    return this.Tmin;
  }
  
  public void setTmin(double tmin)
  {
    this.Tmin = tmin;
  }
  
  public double getTmax()
  {
    return this.Tmax;
  }
  
  public void setTmax(double tmax)
  {
    this.Tmax = tmax;
  }
  
  public double getWmax()
  {
    return this.Wmax;
  }
  
  public void setWmax(double wmax)
  {
    this.Wmax = wmax;
  }
  
  public double getHrain()
  {
    return this.Hrain;
  }
  
  public void setHrain(double hrain)
  {
    this.Hrain = hrain;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getAddress1()
  {
    return this.address1;
  }
  
  public void setAddress1(String address1)
  {
    this.address1 = address1;
  }
  
  public String getAddress2()
  {
    return this.address2;
  }
  
  public void setAddress2(String address2)
  {
    this.address2 = address2;
  }
  
  public String getCity()
  {
    return this.city;
  }
  
  public void setCity(String city)
  {
    this.city = city;
  }
  
  public String getEmail()
  {
    return this.email;
  }
  
  public void setEmail(String email)
  {
    this.email = email;
  }
  
  public int getOid()
  {
    return this.oid;
  }
  
  public void setOid(int oid)
  {
    this.oid = oid;
  }
  
  public int getDstateid()
  {
    return this.dstateid;
  }
  
  public void setDstateid(int dstateid)
  {
    this.dstateid = dstateid;
  }
}
