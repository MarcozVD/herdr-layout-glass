param([string]$Out)
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @"
using System; using System.Drawing; using System.Drawing.Imaging;
public static class Mesh {
  static double[] H(string h){ return new double[]{ Convert.ToInt32(h.Substring(1,2),16), Convert.ToInt32(h.Substring(3,2),16), Convert.ToInt32(h.Substring(5,2),16)}; }
  public static void Make(string path){
    int W=2560,Hh=1640; double s=2.0, rem=16*s;
    var bmp=new Bitmap(W,Hh,PixelFormat.Format24bppRgb);
    var c0=H("#070708"); var c1=H("#111113"); var c2=H("#08080a");
    // blobs: color, alpha, rx, ry (rem), cx, cy (fraction), stop
    var blobs=new object[][]{
      new object[]{H("#ffffff"),0.09,48.0,34.0,0.08,-0.06,0.62},
      new object[]{H("#ffffff"),0.05,42.0,30.0,0.96,0.02,0.64},
      new object[]{H("#ffffff"),0.07,54.0,40.0,0.90,1.06,0.66},
      new object[]{H("#ffffff"),0.04,40.0,30.0,0.02,0.98,0.62}};
    var rnd=new Random(7);
    double ang=160*Math.PI/180, dx=Math.Sin(ang), dy=-Math.Cos(ang);
    double len=Math.Abs(W*dx)+Math.Abs(Hh*dy);
    var data=bmp.LockBits(new Rectangle(0,0,W,Hh),ImageLockMode.WriteOnly,PixelFormat.Format24bppRgb);
    var row=new byte[data.Stride];
    for(int y=0;y<Hh;y++){
      for(int x=0;x<W;x++){
        double t=((x-W/2.0)*dx+(y-Hh/2.0)*dy)/len+0.5; t=Math.Max(0,Math.Min(1,t));
        double[] a,b; double u; if(t<0.55){a=c0;b=c1;u=t/0.55;}else{a=c1;b=c2;u=(t-0.55)/0.45;}
        double r=a[0]+(b[0]-a[0])*u, g=a[1]+(b[1]-a[1])*u, bl=a[2]+(b[2]-a[2])*u;
        foreach(var bb in blobs){
          var col=(double[])bb[0]; double al=(double)bb[1], rx=(double)bb[2]*rem, ry=(double)bb[3]*rem;
          double cx=(double)bb[4]*W, cy=(double)bb[5]*Hh, stop=(double)bb[6];
          double d=Math.Sqrt(Math.Pow((x-cx)/rx,2)+Math.Pow((y-cy)/ry,2))/stop;
          if(d<1){ double k=al*(1-d); r+= (col[0]-r)*k; g+=(col[1]-g)*k; bl+=(col[2]-bl)*k; }
        }
        double n=(rnd.NextDouble()-0.5)*255*0.04*0.5;
        row[x*3]=(byte)Math.Max(0,Math.Min(255,bl+n)); row[x*3+1]=(byte)Math.Max(0,Math.Min(255,g+n)); row[x*3+2]=(byte)Math.Max(0,Math.Min(255,r+n));
      }
      System.Runtime.InteropServices.Marshal.Copy(row,0,data.Scan0+y*data.Stride,data.Stride);
    }
    bmp.UnlockBits(data); bmp.Save(path,ImageFormat.Png);
  }
}
"@
[Mesh]::Make($Out)
