--1) Ogrencilerin ogrenci numaralarini, adlarini ve soyadlarini raporlayiniz (M.Akgul formatinda olacak)
--select o.OgrenciNo,left(k.Ad,1)+'.'+k.Soyad 'Ad Soyad' from Ogrenciler o 
--inner join Kimlikler k on k.KimlikID=o.KimlikID

--2) Ogretmenlerin unvanlarini, adlarini, soyadlarini raporlayiniz
--select og.Unvan+' '+og.Ad +' '+og.Soyad 'Ogretim Elemanlari' from Ogretmenler og

--3) Hangi ogrenci kac yildir okuyor goster
--SELECT o.OgrenciNo, YEAR(GETDATE())-o.KayitYili as 'Ogrenim Suresi' FROM Ogrenciler o

--4) Puani 2 altinda olan ogrencileri ogrenciNo, ad, soyad, gpa, üniversite adi olarak listele
--select o.OgrenciNo, k.Ad+' '+k.Soyad 'Ad Soyad', o.GPA, u.UniversiteAdi 
--from Ogrenciler o inner join Kimlikler k on k.KimlikID=o.KimlikID
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--inner join Universiteler u on u.UniversiteID=f.UniversiteID
--where o.GPA<2

--5) Hangi ogrenci hangi bolumde ogrenim goruyor?(ogrenci adina gore a-z) ogrenci ad, soyad ve bolum adi, uni adi
--select k.Ad, k.Soyad, b.BolumAdi, u.UniversiteAdi
--from Ogrenciler o inner join Bolumler b on o.BolumID=b.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--inner join Universiteler u on u.UniversiteID=f.UniversiteID
--inner join Kimlikler k on k.KimlikID=o.KimlikID
--order by k.Ad asc

--6) Her üniversitede ogretmenlerin kaci doktor ve kaci profesor (uni adi, unvan, sayi)
--select u.UniversiteAdi, og.Unvan, COUNT(og.OgretmenID) 'Ogretim Uyesi Sayisi'
--from Ogretmenler og
--inner join Dersler d on d.DersID=og.DersID
--inner join Bolumler b on b.BolumID=d.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--inner join Universiteler u on u.UniversiteID=f.UniversiteID
--where og.Unvan in('Prof. Dr.','Dr.')
--group by u.UniversiteAdi, og.Unvan
--order by u.UniversiteAdi

--7) Butun unilerde her fakultede toplam kac ogrenci var (fakulte, sayi)
--select f.FakulteAdi, COUNT(o.OgrenciID) 'Ogrenci Sayisi'
--from Ogrenciler o
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--group by f.FakulteAdi

--8) Her fakultede notu 3 ile 3.5 arasinda olan kac ogrenci var (fakulte, sayi)
--select f.FakulteAdi, COUNT(o.OgrenciID) 'GPA 3-3.5 olan Ogrenci Sayisi'
--from Ogrenciler o
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--where o.GPA between 3 and 3.5
--group by f.FakulteAdi

--9) Yasi 24den buyuk olan ogrencileri listele (ad-soyad,ogrenci no, yas)
--select k.Ad+' '+k.Soyad 'Ad Soyad', o.OgrenciNo, DATEDIFF(YEAR, k.DogumTarihi, GETDATE()) 'Yas'
--from Ogrenciler o inner join Kimlikler k on k.KimlikID=o.KimlikID
--where DATEDIFF(YEAR, k.DogumTarihi, GETDATE())>24

--10) Muhendislik fakultesinde okumayan kac ogrenci var
--select COUNT(o.OgrenciID) 'Mühendislik Okumayan Ogrenci Sayisi'
--from Ogrenciler o
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--where f.FakulteAdi not like 'Mühendislik%'

--11) Fen fakultesinde okumayan puani 3.5 uzerinde olan kac ogrenci var
--select COUNT(o.OgrenciID) 'Fen Fakultesinde okumayan GPA 3.5 uzerinde Ogrenci Sayisi'
--from Ogrenciler o
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--where f.FakulteAdi not like 'Fen%' and o.GPA>3.5

--12) Ogretmenleri en fazla ogrenciye ders verenden en aza sýrala (unvan, ad-soyad, ogrenci sayisi)
--select og.Unvan+' '+og.Ad+' '+og.Soyad 'Ad Soyad', COUNT(o.OgrenciID) 'Ogrenci Sayisi'
--from Ogretmenler og
--inner join Dersler d on d.DersID=og.DersID
--inner join Bolumler b on b.BolumID=d.BolumID
--inner join Ogrenciler o on o.BolumID=b.BolumID
--group by og.Unvan+' '+og.Ad+' '+og.Soyad
--order by [Ogrenci Sayisi] desc

--13) Her bir yil kac ogrenci kayit olmustur
--select o.KayitYili, COUNT(o.OgrenciID) 'Kaydolan Ogrenci Sayisi' from Ogrenciler o
--group by o.KayitYili

--14) Yasi 23den buyuk bilgisayar muhendisliginde okumayan ogrencileri listele
--select k.Ad+' '+k.Soyad 'Ad Soyad', b.BolumAdi, DATEDIFF(YEAR,k.DogumTarihi,GETDATE()) 'Yas'
--from Ogrenciler o
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Kimlikler k on k.KimlikID=o.KimlikID
--where b.BolumAdi<>'Bilgisayar Mühendisliði' and DATEDIFF(YEAR,k.DogumTarihi,GETDATE())>23

--15) En fazla ogrenci bulunan universitenin adi, sehri ve ogrenci sayisi
--select top 1 u.UniversiteAdi, s.SehirAdi, COUNT(o.OgrenciID) 'Ogrenci Sayisi'
--from Universiteler u
--inner join Sehirler s on s.SehirID=u.SehirID
--inner join Fakulteler f on f.UniversiteID=u.UniversiteID
--inner join Bolumler b on b.FakulteID=f.FakulteID
--inner join Ogrenciler o on o.BolumID=b.BolumID
--group by u.UniversiteAdi, s.SehirAdi
--order by [Ogrenci Sayisi] desc

--16) ÝTÜ'de dersleri en düþük krediden yükseðe sirala
--select b.BolumAdi, d.DersAdi, d.Kredi 
--from Universiteler u
--inner join Fakulteler f on f.UniversiteID=u.UniversiteID
--inner join Bolumler b on b.FakulteID=f.FakulteID
--inner join Dersler d on d.BolumID=b.BolumID
--where u.UniversiteAdi='Ýstanbul Teknik Üniversitesi'
--order by d.Kredi

--17) Adinda a harfi ve soyadinda u veya ü harfi bulunan ogrencileri listele
--select *
--from Kimlikler k
--where k.Ad like '%a%' and k.Soyad like '%[uü]%'

--18) Adinin ikinci harfi g ile k arasinda olan ogrencileri listele
--select *
--from Kimlikler k
--where k.Ad like '_[g-k]%'

--19) Isminin son iki harfi an olan ogrencileri puanlarina gore buyukten kucuge sirala
--select k.Ad+' '+k.Soyad 'Ad Soyad', o.GPA
--from Kimlikler k
--inner join Ogrenciler o on o.KimlikID=k.KimlikID
--where k.Ad like '%an'
--order by o.GPA desc

--20) Ogrencilerin suanki yaslarini ve kac yasinda kayit olduklarini raporla
--select k.Ad+' '+k.Soyad 'Ad Soyad', DATEDIFF(YEAR,k.DogumTarihi,GETDATE()) 'Yas', o.KayitYili-YEAR(k.DogumTarihi) 'Kayit Yasi'
--from Kimlikler k
--inner join Ogrenciler o on k.KimlikID=o.KimlikID

--21) Ogrenciler tablosuna kendinizi ekleyin
--select *from Ogrenciler where OgrenciNo='1790'

--insert Ogrenciler(OgrenciNo,KayitYili,GPA) values('2121',2024,3.6)

--22) 555 id'li ogrencinin bolumunu bilgisayar muhendisligi olarak degistiriniz
--update Ogrenciler set BolumID=30 where OgrenciID=555

--select o.OgrenciNo, b.BolumAdi, f.FakulteAdi, u.UniversiteAdi
--from Ogrenciler o
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--inner join Universiteler u on u.UniversiteID=f.UniversiteID
--where o.OgrenciID=555

--23) ÝTÜ Mühendislik Fakültesine Mekatronik Muhendisligi ekleyiniz
--select *
--from Universiteler u
--inner join Fakulteler f on f.UniversiteID=u.UniversiteID
--inner join Bolumler b on b.FakulteID=f.FakulteID

--insert Bolumler(BolumAdi, BolumKodu, FakulteID) values('Mekatronik Mühendisliði', '104', 1)

--24) Hicbir ogrencinin okumadigi bolumleri siliniz
--select *
--from Bolumler b
--left join Ogrenciler o on o.BolumID=b.BolumID
--where o.BolumID is null

--delete b
--from Bolumler b
--left join Ogrenciler o on o.BolumID=b.BolumID
--where o.BolumID is null

--25) 2021 yili ve oncesinde kayit yapmis olan ogrencilerin adi, soyadi, yasi, kayit yili,
--puani, bolumu ve uni adini ogrenci adina gore a-z siralayip gosteren sanal tablo olusturunuz
--create view KayitYili2021Oncesi
--as
--select k.Ad+' '+k.Soyad 'Ad Soyad', DATEDIFF(YEAR,k.DogumTarihi,GETDATE()) 'Yas', o.KayitYili, o.GPA, b.BolumAdi, u.UniversiteAdi
--from Ogrenciler o
--inner join Kimlikler k on k.KimlikID=o.KimlikID
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--inner join Universiteler u on u.UniversiteID=f.UniversiteID
--where o.KayitYili<2021

--select *from KayitYili2021Oncesi
--order by [Ad Soyad] asc

--26) Yeni ogrenci eklemek ve ogrenci silmek icin iki ayrý proc olustur (eklerken bolum girilmezse null olsun)
--create proc OgrenciEkle
--(
--@kayitYili int,
--@gpa decimal(3,2),
--@bolum int=null
--)
--as
--begin
--declare @ogrenciNo int
--select @ogrenciNo= MAX(OgrenciNo)+1 from Ogrenciler
--insert Ogrenciler(OgrenciNo,KayitYili,BolumID,GPA) values(@ogrenciNo,@kayitYili,@bolum,@gpa)
--end

--exec OgrenciEkle 2024,3.5

--select *from Ogrenciler order by OgrenciNo desc


--create proc OgrenciSil
--(
--@ogrenciNo int
--)
--as
--delete from Ogrenciler where OgrenciNo=@ogrenciNo

--exec OgrenciSil 2122

--select *from Ogrenciler order by OgrenciNo desc

--27) Girilen ogrenci numarasina ait ad, soyad, gpa, aldigi dersler, bolum, uni donduren func
--create function OgrenciBilgisi
--(
--@ogrenciNo int
--)
--returns table
--as
--return select k.Ad,k.Soyad,o.GPA, d.DersAdi,b.BolumAdi,u.UniversiteAdi from Ogrenciler o 
--inner join Kimlikler k on k.KimlikID=o.KimlikID
--inner join Bolumler b on b.BolumID=o.BolumID
--inner join Dersler d on d.BolumID=b.BolumID
--inner join Fakulteler f on f.FakulteID=b.FakulteID
--inner join Universiteler u on u.UniversiteID=f.UniversiteID
--where o.OgrenciNo=@ogrenciNo

--select *from dbo.OgrenciBilgisi(1789)

--28) Girilen ogrenci numarasina ait ogrenci varsa girilen puana gore gpa guncelleyen
-- yoksa ogrenci bulunamadi yazdýran proc olustur
--create proc UpdateGPA
--(
--@ogrenciNo int,
--@gpa decimal(3,2)
--)
--as
--if not exists(select * from Ogrenciler o where o.OgrenciNo=@ogrenciNo)
--begin
--print 'Girilen numaraya ait ogrenci bulunamadi!'
--end
--else
--begin
--update Ogrenciler set GPA=@gpa where OgrenciNo=@ogrenciNo
--end

--exec UpdateGPA 1789,2.55

--select *from Ogrenciler where OgrenciNo=1789

--29) SilinenOgrenciler adinda bir tablo olustur ve Ogrenciler tablosunda her ogrenci silindiginde
--silinen ogrencinin numarasini ve silinme tarihini bu tabloya ekleyen trigger olustur
--create table SilinenOgrenciler(
--ID int primary key identity(1,1),
--OgrenciNo int not null,
--SilmeTarihi datetime not null default getdate()
--);

--create trigger OgrenciSilindi
--on Ogrenciler
--after delete
--as
--declare @ogrenciNo int
--select @ogrenciNo=OgrenciNo from deleted
--insert SilinenOgrenciler(OgrenciNo) values(@ogrenciNo)

--30) SilinenOgrenciler tablosundaki verileri getiren bir sanal tablo olusturun
--tablonun bagli oldugu kolonlar silinmemeli ve kodlar gozekmemeli
--create view SilinmisOgrenciler
--with schemabinding,encryption
--as
--select so.ID, so.OgrenciNo, so.SilmeTarihi from dbo.SilinenOgrenciler so

--select *from SilinmisOgrenciler