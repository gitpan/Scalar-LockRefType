#! perl
use Module::Build;

Module::Build->new(
    module_name => 'Scalar::LockRefType',
    dist_abstract => 'simple scalar ref type checker',
    version_from => 'lib/Scalar/LockRefType.pm',
    build_requires => {
	Test::Exception => 0,
    },
    requires => {
	perl => '5.0',
    }
)->create_build_script;
