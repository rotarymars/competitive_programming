#include <iostream>
#ifdef _DEBUG
#define DP(x) cout << #x << " = " << x << endl
#else
#define DP(x) ;
#endif
using namespace std;
signed main()
{
    cin.tie(nullptr);
    ios_base::sync_with_stdio(false);
    int a,b;
    cin>>a>>b;
    if(a+b==15)cout<<'+'<<endl;
    else if(a*b==15)cout<<'*'<<endl;
    else cout<<'x'<<endl;
    return 0;
}