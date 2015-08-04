import string		
import urllib		
import urllib2		
import re		
import os		
		
#FUnction： Get begin-end page and stored into a folder.		
def threeu_page(burl,url,begin_page,end_page) :		
    		
    #The directory to save web page		
    sPagePath = './treeuPage'		
    if not os.path.exists(sPagePath) : 		
        os.mkdir(sPagePath)		
		
    #The director to save downloaded file		
    sFilePath = './threeuFile'		
    if not os.path.exists(sFilePath) : 		
        os.mkdir(sFilePath)		
		
    for i in range(begin_page,end_page+1) :		
        pn = (i-1)*25		
        #Genrate a file name bu auto-filling		
        sName = sPagePath + '/'+ string.zfill(i,5) + '.html'		
        print 'Spidering the ' + str(i) + ' page ,saved to ' + sName + '...'		
        f = open(sName,'w+')  		
        user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'		
        headers = { 'User-Agent' : user_agent }		
        request = urllib2.Request(url+str(pn),headers = headers)		
		
        try: 		
            con = urllib2.urlopen(request, timeout=10).read()		
            #Reg Exp to match to address		
            myItems = re.findall('<a href="bp-(.*?).html" title="(.*?)" target="_blank">(.*?)</a>',con,re.S)		
            #print "Total : ",len(myItems)		
            for item in myItems :		
                print 'Dowloading the ' +item[0] + "  "+ item[1].decode('gbk') + '...'		
                #Retrive		
                durl = burl+item[0]+'-toword.doc'		
                urllib.urlretrieve(durl,sFilePath+'/'+item[1].decode('gbk')+'.doc')         		
        except urllib2.URLError,e :		
            print e		
        else:		
            f.write(con)		
        f.close()		
		
#First domain address		
burl = 'http://3y.uu456.com/dlDoc-'		
iurl = 'http://3y.uu456.com/bl-197?od=1&pn='		
ibegin = 1		
iend = 1		
threeu_page(burl,iurl,ibegin,iend)		
#end
