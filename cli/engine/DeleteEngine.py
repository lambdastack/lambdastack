from cli.helpers.Step import Step
from cli.helpers.doc_list_helpers import select_single
from cli.engine.terraform.TerraformRunner import TerraformRunner
from cli.helpers.build_io import delete_directory, load_manifest

class DeleteEngine(Step):
    def __init__(self, input_data):
        super().__init__(__name__)
        self.build_directory = input_data.build_directory

    def __enter__(self):
        super().__enter__()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        pass

    def delete(self):
        docs = load_manifest(self.build_directory)
        cluster_model = select_single(docs, lambda x: x.kind == 'lambdastack-cluster')

        if cluster_model.provider == 'any':
            raise Exception('Delete works only for cloud providers')

        with TerraformRunner(cluster_model, docs) as tf_runner:
            tf_runner.delete()

        delete_directory(self.build_directory)

        return 0
