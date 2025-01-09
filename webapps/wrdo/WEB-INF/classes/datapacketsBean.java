package com;

public class datapacketsBean
{
  private String dtime;
  private String fdate;
  private String tdate;
  private String packetno;
  private int station_id;
  private float rain;
  private float temp;
  private float wind;
  private float wind_direction;
  private float mslp;
  private float humidity;
  private float local_pressure;
  
  public String getDtime()
  {
    return this.dtime;
  }
  
  public void setDtime(String dtime)
  {
    this.dtime = dtime;
  }
  
  public String getFdate()
  {
    return this.fdate;
  }
  
  public void setFdate(String fdate)
  {
    this.fdate = fdate;
  }
  
  public String getTdate()
  {
    return this.tdate;
  }
  
  public void setTdate(String tdate)
  {
    this.tdate = tdate;
  }
  
  public int getStation_id()
  {
    return this.station_id;
  }
  
  public void setStation_id(int station_id)
  {
    this.station_id = station_id;
  }
  
  public String getPacketno()
  {
    return this.packetno;
  }
  
  public void setPacketno(String packetno)
  {
    this.packetno = packetno;
  }
  
  public float getRain()
  {
    return this.rain;
  }
  
  public void setRain(float rain)
  {
    this.rain = rain;
  }
  
  public float getTemp()
  {
    return this.temp;
  }
  
  public void setTemp(float temp)
  {
    this.temp = temp;
  }
  
  public float getWind()
  {
    return this.wind;
  }
  
  public void setWind(float wind)
  {
    this.wind = wind;
  }
  
  public float getWind_direction()
  {
    return this.wind_direction;
  }
  
  public void setWind_direction(float wind_direction)
  {
    this.wind_direction = wind_direction;
  }
  
  public float getMslp()
  {
    return this.mslp;
  }
  
  public void setMslp(float mslp)
  {
    this.mslp = mslp;
  }
  
  public float getHumidity()
  {
    return this.humidity;
  }
  
  public void setHumidity(float humidity)
  {
    this.humidity = humidity;
  }
  
  public float getLocal_pressure()
  {
    return this.local_pressure;
  }
  
  public void setLocal_pressure(float local_pressure)
  {
    this.local_pressure = local_pressure;
  }
}
