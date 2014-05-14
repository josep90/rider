using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(rider.Startup))]
namespace rider
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
